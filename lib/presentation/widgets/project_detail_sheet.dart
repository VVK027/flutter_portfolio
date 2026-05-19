import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/presentation/widgets/portfolio_asset_icon.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/presentation/widgets/project_preview.dart';

void showProjectDetail(BuildContext context, Project project) {
  final isMobile = MediaQuery.sizeOf(context).width < 600;

  if (isMobile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ProjectDetailContent(project: project),
    );
  } else {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: _ProjectDetailContent(project: project),
        ),
      ),
    );
  }
}

class _ProjectDetailContent extends StatelessWidget {
  final Project project;
  const _ProjectDetailContent({required this.project});

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open link')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final previewImage = (project.previewImage ?? '').trim();
    final hasPreview = previewImage.isNotEmpty;
    final playStoreUrls = project.playStoreUrl;
    final appStoreUrls = project.appStoreUrl;
    final githubUrl = (project.githubUrl ?? '').trim();
    final hasPlayStore = playStoreUrls.isNotEmpty;
    final hasAppStore = appStoreUrls.isNotEmpty;
    final hasGithub = githubUrl.isNotEmpty;
    final descriptions = project.fullDescription ?? [project.desc];
    final features = project.features ?? [];
    final hasFeatures = features.isNotEmpty;

    return Container(
      constraints: const BoxConstraints(maxHeight: 700),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.cardBorder),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              hasPreview
                  ? _buildPreviewImage(context, previewImage)
                  : projectPreviewPlaceholder(context, project.name),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'About Project',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      ...descriptions.map(
                        (point) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Icon(Icons.circle,
                                    size: 6, color: colors.textMuted),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  point,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colors.textSecondary,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (hasFeatures) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Key Features',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: features
                              .map(
                                (feature) => Chip(
                                  label: Text(feature),
                                  labelStyle: theme.textTheme.bodySmall
                                      ?.copyWith(color: colors.success),
                                  side: BorderSide(
                                    color: colors.success.withValues(alpha: 0.35),
                                  ),
                                  backgroundColor:
                                      colors.success.withValues(alpha: 0.1),
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Text(
                        'Technologies Used',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.tags
                            .map(
                              (tag) => Chip(
                                label: Text(tag),
                                labelStyle: theme.textTheme.bodySmall
                                    ?.copyWith(color: colors.accent),
                                side: BorderSide(
                                  color: colors.accent.withValues(alpha: 0.35),
                                ),
                                backgroundColor:
                                    colors.accent.withValues(alpha: 0.1),
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: (hasPlayStore || hasAppStore || hasGithub)
                    ? SizedBox(
                        height: 48,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _buildDetailLinkButtons(
                              context,
                              playStoreUrls: playStoreUrls,
                              appStoreUrls: appStoreUrls,
                              githubUrl: hasGithub ? githubUrl : null,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Icon(Icons.lock_outline,
                              size: 18, color: colors.internalLabel),
                          const SizedBox(width: 8),
                          Text(
                            'Internal Project',
                            style: TextStyle(
                              color: colors.internalLabel,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),

          // Close button pinned to top-right corner of the dialog
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, size: 20),
              style: IconButton.styleFrom(
                backgroundColor: colors.card.withValues(alpha: 0.9),
                foregroundColor: colors.textPrimary,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDetailLinkButtons(
    BuildContext context, {
    required List<String> playStoreUrls,
    required List<String> appStoreUrls,
    required String? githubUrl,
  }) {
    final colors = context.appColors;
    final widgets = <Widget>[];

    for (int i = 0; i < playStoreUrls.length; i++) {
      if (widgets.isNotEmpty) widgets.add(const SizedBox(width: 10));
      final label =
          playStoreUrls.length > 1 ? 'Play Store ${i + 1}' : 'Play Store';
      widgets.add(
        FilledButton.icon(
          onPressed: () => _openUrl(context, playStoreUrls[i]),
          icon: const Icon(Icons.play_arrow_rounded, size: 20),
          label: Text(label),
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            backgroundColor: colors.success,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    for (int i = 0; i < appStoreUrls.length; i++) {
      if (widgets.isNotEmpty) widgets.add(const SizedBox(width: 10));
      final label =
          appStoreUrls.length > 1 ? 'App Store ${i + 1}' : 'App Store';
      widgets.add(
        FilledButton.icon(
          onPressed: () => _openUrl(context, appStoreUrls[i]),
          icon: const Icon(Icons.apple, size: 20),
          label: Text(label),
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            backgroundColor: colors.textPrimary,
            foregroundColor: colors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    if (githubUrl != null) {
      if (widgets.isNotEmpty) widgets.add(const SizedBox(width: 10));
      widgets.add(
        FilledButton.icon(
          onPressed: () => _openUrl(context, githubUrl),
          icon: const PortfolioAssetIcon(
            icon: PortfolioIcon.github,
            size: 18,
          ),
          label: const Text('GitHub'),
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            backgroundColor: colors.chipBackground,
            foregroundColor: colors.textPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildPreviewImage(BuildContext context, String imagePath) {
    return ProjectPreviewFrame(
      child: projectPreviewImage(
        imagePath,
        fallbackTitle: project.name,
        fit: BoxFit.contain,
      ),
    );
  }
}
