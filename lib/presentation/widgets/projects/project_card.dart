import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/presentation/widgets/portfolio_asset_icon.dart';
import 'package:vivekdevfolio/presentation/widgets/project_detail_sheet.dart';
import 'package:vivekdevfolio/presentation/widgets/project_preview.dart';
import 'package:vivekdevfolio/presentation/widgets/projects/project_card_view_data.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final double previewHeight;

  const ProjectCard({
    super.key,
    required this.project,
    required this.previewHeight,
  });

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open link')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewData = ProjectCardViewData.fromProject(project);
    final colors = context.appColors;

    return GestureDetector(
      onTap: () => showProjectDetail(context, project),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.card,
            border: Border.all(color: colors.cardBorder),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectPreviewFrame(
                height: previewHeight,
                child: viewData.hasPreviewImage
                    ? projectPreviewImage(
                        viewData.previewImage,
                        fallbackTitle: project.name,
                      )
                    : projectPreviewPlaceholder(context, project.name),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.desc,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: colors.textMuted),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (project.tags.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                for (final tag in project.tags)
                                  Chip(
                                    label: Text(tag),
                                    visualDensity: VisualDensity.compact,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontSize: 11.5),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ] else
                        const Spacer(),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 36,
                        child: viewData.hasStoreLinks
                            ? ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                children: _buildLinkButtons(context, viewData),
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    size: 14,
                                    color: colors.internalLabel,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      'Internal Project',
                                      style: TextStyle(
                                        color: colors.internalLabel,
                                        fontSize: 13,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLinkButtons(
    BuildContext context,
    ProjectCardViewData viewData,
  ) {
    final colors = context.appColors;
    final widgets = <Widget>[];

    for (int i = 0; i < viewData.playStoreUrls.length; i++) {
      if (widgets.isNotEmpty) widgets.add(const SizedBox(width: 8));
      final label = viewData.playStoreUrls.length > 1
          ? 'Play Store ${i + 1}'
          : 'Play Store';
      widgets.add(
        OutlinedButton.icon(
          onPressed: () => _openUrl(context, viewData.playStoreUrls[i]),
          icon: const Icon(Icons.play_arrow_rounded, size: 16),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 34),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            foregroundColor: colors.playStoreFg,
            side: BorderSide(color: colors.playStoreBorder),
          ),
        ),
      );
    }

    for (int i = 0; i < viewData.appStoreUrls.length; i++) {
      if (widgets.isNotEmpty) widgets.add(const SizedBox(width: 8));
      final label = viewData.appStoreUrls.length > 1
          ? 'App Store ${i + 1}'
          : 'App Store';
      widgets.add(
        OutlinedButton.icon(
          onPressed: () => _openUrl(context, viewData.appStoreUrls[i]),
          icon: const Icon(Icons.apple, size: 16),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 34),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            foregroundColor: colors.appStoreFg,
            side: BorderSide(color: colors.appStoreBorder),
          ),
        ),
      );
    }

    if (viewData.hasGithub) {
      if (widgets.isNotEmpty) widgets.add(const SizedBox(width: 8));
      widgets.add(
        OutlinedButton.icon(
          onPressed: () => _openUrl(context, viewData.githubUrl!),
          icon: const PortfolioAssetIcon(
            icon: PortfolioIcon.github,
            size: 14,
          ),
          label: const Text('GitHub'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 34),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            foregroundColor: colors.githubFg,
            side: BorderSide(color: colors.githubBorder),
          ),
        ),
      );
    }

    return widgets;
  }
}
