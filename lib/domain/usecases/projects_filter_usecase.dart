import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class ProjectsFilterUseCase {
  const ProjectsFilterUseCase();

  List<String> collectTags(Portfolio? portfolio, {required String allTag}) {
    if (portfolio == null) return [allTag];
    final tags = <String>{
      allTag,
      ...portfolio.projects
          .where((p) => !p.isOpenSource)
          .expand((project) => project.tags)
    };
    return tags.toList(growable: false);
  }

  List<Project> filterProjects(
    Portfolio? portfolio,
    String filter, {
    required String allTag,
  }) {
    if (portfolio == null) return const [];
    final nonOpenSource =
        portfolio.projects.where((p) => !p.isOpenSource).toList();
    if (filter == allTag) return nonOpenSource;
    return nonOpenSource
        .where((project) => project.tags.contains(filter))
        .toList(growable: false);
  }

  List<Project> getOpenSourceProjects(Portfolio? portfolio) {
    if (portfolio == null) return const [];
    return portfolio.projects
        .where((project) => project.isOpenSource)
        .toList(growable: false);
  }
}
