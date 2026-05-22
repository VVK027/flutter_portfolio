import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class ProjectCardViewData {
  final List<String> playStoreUrls;
  final List<String> appStoreUrls;
  final String? githubUrl;
  final String previewImage;
  final bool hasPlayStore;
  final bool hasAppStore;
  final bool hasGithub;
  final bool hasPreviewImage;

  bool get hasStoreLinks => hasPlayStore || hasAppStore || hasGithub;

  const ProjectCardViewData({
    required this.playStoreUrls,
    required this.appStoreUrls,
    required this.githubUrl,
    required this.previewImage,
    required this.hasPlayStore,
    required this.hasAppStore,
    required this.hasGithub,
    required this.hasPreviewImage,
  });

  factory ProjectCardViewData.fromProject(Project project) {
    final playStoreUrls = project.playStoreUrl;
    final appStoreUrls = project.appStoreUrl;
    final githubUrl = (project.githubUrl ?? '').trim();
    final previewImage = (project.previewImage ?? '').trim();
    final hasPlayStore = playStoreUrls.isNotEmpty;
    final hasAppStore = appStoreUrls.isNotEmpty;
    final hasGithub = githubUrl.isNotEmpty;
    final hasPreviewImage = previewImage.isNotEmpty;

    return ProjectCardViewData(
      playStoreUrls: playStoreUrls,
      appStoreUrls: appStoreUrls,
      githubUrl: hasGithub ? githubUrl : null,
      previewImage: previewImage,
      hasPlayStore: hasPlayStore,
      hasAppStore: hasAppStore,
      hasGithub: hasGithub,
      hasPreviewImage: hasPreviewImage,
    );
  }
}

/// Extra space below the footer content inside the carousel page.
const projectCardPageBottomInset = 8.0;

/// Base footer height when a project has no tags.
const projectCardFooterBaseHeight = 32.0 +
    20.0 +
    4.0 +
    36.0 +
    8.0 +
    36.0 +
    20.0;

/// Largest estimated footer height across [tagLists] for a given [cardWidth].
double maxProjectCardFooterHeight(
  Iterable<List<String>> tagLists, {
  required double cardWidth,
}) {
  var max = projectCardFooterBaseHeight;
  for (final tags in tagLists) {
    final height = projectCardFooterHeight(tags: tags, cardWidth: cardWidth);
    if (height > max) max = height;
  }
  return max;
}

/// Estimates footer height (title, description, wrapped tags, buttons, padding).
double projectCardFooterHeight({
  required List<String> tags,
  required double cardWidth,
}) {
  const verticalPadding = 32.0;
  const tagsTopGap = 6.0;
  const chipHeight = 32.0;
  const runSpacing = 6.0;
  const chipSpacing = 6.0;

  final height = projectCardFooterBaseHeight;

  if (tags.isEmpty) return height;

  final tagsWidth = cardWidth - verticalPadding;
  final tagRows = _countTagWrapRows(tags, maxWidth: tagsWidth, spacing: chipSpacing);
  final tagsHeight = tagRows * chipHeight + (tagRows - 1) * runSpacing;

  return height + tagsTopGap + tagsHeight;
}

int _countTagWrapRows(
  List<String> tags, {
  required double maxWidth,
  required double spacing,
}) {
  var rows = 1;
  var rowWidth = 0.0;

  for (final tag in tags) {
    final chipWidth = _estimateTagChipWidth(tag);
    final needed = rowWidth == 0 ? chipWidth : rowWidth + spacing + chipWidth;
    if (needed > maxWidth && rowWidth > 0) {
      rows++;
      rowWidth = chipWidth;
    } else {
      rowWidth = needed;
    }
  }

  return rows;
}

double _estimateTagChipWidth(String tag) {
  // Matches compact Chip: horizontal padding + ~7px per character at 11.5pt.
  const horizontalPadding = 28.0;
  const charWidth = 7.0;
  return horizontalPadding + tag.length * charWidth;
}
