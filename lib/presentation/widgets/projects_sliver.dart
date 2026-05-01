import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';

class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double web = 1300;
  static int columnsFor(double width) {
    if (width < mobile) return 1;
    if (width < tablet) return 2;
    if (width < web) return 3;
    return 4;
  }
}

class ProjectsSliver extends StatelessWidget {
  final List<Project> items;
  const ProjectsSliver({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = Breakpoints.columnsFor(constraints.maxWidth);
        final aspect = constraints.maxWidth < 600
            ? 0.76
            : constraints.maxWidth < 1000
            ? 0.84
            : 0.94;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: aspect,
          ),
          itemBuilder: (context, i) => _ProjectCard(project: items[i]),
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  const _ProjectCard({required this.project});

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open link')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final playStoreUrl = (project.playStoreUrl ?? '').trim();
    final appStoreUrl = (project.appStoreUrl ?? '').trim();
    final previewImage = (project.previewImage ?? '').trim();
    final hasPlayStore = playStoreUrl.isNotEmpty;
    final hasAppStore = appStoreUrl.isNotEmpty;
    final hasPreviewImage = previewImage.isNotEmpty;
    final descriptionLines = (hasPlayStore || hasAppStore || hasPreviewImage)
        ? 2
        : 3;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B29),
        border: Border.all(color: const Color(0xFF323A52)),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (hasPreviewImage) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _projectImage(previewImage),
              ),
            ),
            const SizedBox(height: 10),
          ],
          Text(
            project.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  project.desc,
                  style: const TextStyle(color: Colors.grey),
                  maxLines: descriptionLines,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 32,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: project.tags.length,
                    separatorBuilder: (_, index) => const SizedBox(width: 6),
                    itemBuilder: (context, index) => Chip(
                      label: Text(project.tags[index]),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (hasPlayStore || hasAppStore) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (hasPlayStore)
                  OutlinedButton.icon(
                    onPressed: () => _openUrl(context, playStoreUrl),
                    icon: const Icon(Icons.play_arrow_rounded, size: 16),
                    label: const Text('Play Store'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFB8E1FF),
                      side: const BorderSide(color: Color(0xFF476186)),
                    ),
                  ),
                if (hasAppStore)
                  OutlinedButton.icon(
                    onPressed: () => _openUrl(context, appStoreUrl),
                    icon: const Icon(Icons.apple, size: 16),
                    label: const Text('App Store'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFD5DBFF),
                      side: const BorderSide(color: Color(0xFF4E5370)),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _projectImage(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (_, error, stackTrace) => _imageFallback(),
      );
    }
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (_, error, stackTrace) => _imageFallback(),
    );
  }

  Widget _imageFallback() {
    return Container(
      color: const Color(0xFF242B3D),
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.white70,
      ),
    );
  }
}
