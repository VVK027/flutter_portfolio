import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivek_portfolio/application/portfolio/providers/portfolio_providers.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';

const allProjectsFilter = 'All';

final projectsFilterProvider = StateProvider<String>((_) => allProjectsFilter);

final projectTagsProvider = Provider<List<String>>((ref) {
  final portfolio = ref.watch(portfolioFutureProvider).valueOrNull;
  if (portfolio == null) return const [allProjectsFilter];
  final tags = <String>{
    allProjectsFilter,
    ...portfolio.projects.expand((e) => e.tags),
  };
  return tags.toList(growable: false);
});

final filteredProjectsProvider = Provider<List<Project>>((ref) {
  final portfolio = ref.watch(portfolioFutureProvider).valueOrNull;
  final filter = ref.watch(projectsFilterProvider);
  if (portfolio == null) return const [];
  if (filter == allProjectsFilter) return portfolio.projects;
  return portfolio.projects
      .where((p) => p.tags.contains(filter))
      .toList(growable: false);
});
