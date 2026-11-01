import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viivekportfolio/presentation/portfolio/providers/portfolio_providers.dart';
import 'package:viivekportfolio/domain/entities/portfolio.dart';

const allProjectsFilter = 'All';

final projectsFilterProvider = StateProvider<String>((_) => allProjectsFilter);

final projectSearchQueryProvider = StateProvider<String>((_) => '');

final projectTagsProvider = Provider<List<String>>((ref) {
  final portfolio = ref.watch(portfolioFutureProvider).valueOrNull;
  final useCase = ref.read(projectsFilterUseCaseProvider);
  return useCase.collectTags(portfolio, allTag: allProjectsFilter);
});

final filteredProjectsProvider = Provider<List<Project>>((ref) {
  final portfolio = ref.watch(portfolioFutureProvider).valueOrNull;
  final filter = ref.watch(projectsFilterProvider);
  final searchQuery = ref.watch(projectSearchQueryProvider).toLowerCase().trim();
  final useCase = ref.read(projectsFilterUseCaseProvider);
  
  var projects = useCase.filterProjects(
    portfolio,
    filter,
    allTag: allProjectsFilter,
  );

  if (searchQuery.isNotEmpty) {
    projects = projects.where((p) {
      final nameMatch = p.name.toLowerCase().contains(searchQuery);
      final descMatch = p.desc.toLowerCase().contains(searchQuery);
      final tagMatch = p.tags.any((t) => t.toLowerCase().contains(searchQuery));
      return nameMatch || descMatch || tagMatch;
    }).toList(growable: false);
  }

  return projects;
});

final openSourceProjectsProvider = Provider<List<Project>>((ref) {
  final portfolio = ref.watch(portfolioFutureProvider).valueOrNull;
  final useCase = ref.read(projectsFilterUseCaseProvider);
  return useCase.getOpenSourceProjects(portfolio);
});
