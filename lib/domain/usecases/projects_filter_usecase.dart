import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class ProjectsFilterUseCase {
  const ProjectsFilterUseCase();

  List<String> collectTags(Portfolio? portfolio, {required String allTag}) {
    if (portfolio == null) return [allTag];
    final tags = <String>{allTag, ...portfolio.projects.expand((project) => project.tags)};
    return tags.toList(growable: false);
  }

  List<Project> filterProjects(
    Portfolio? portfolio,
    String filter, {
    required String allTag,
  }) {
    if (portfolio == null) return const [];
    if (filter == allTag) return portfolio.projects;
    return portfolio.projects
        .where((project) => project.tags.contains(filter))
        .toList(growable: false);
  }
}
