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

/// Room for title, description, wrapped tags, and link buttons below the preview.
const projectCardMaxFooterHeight = 196.0;
const projectCardPadding = 32.0;
