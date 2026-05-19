import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivekdevfolio/presentation/portfolio/providers/portfolio_providers.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';

const allProjectsFilter = 'All';

final projectsFilterProvider = StateProvider<String>((_) => allProjectsFilter);

final projectTagsProvider = Provider<List<String>>((ref) {
  final portfolio = ref.watch(portfolioFutureProvider).valueOrNull;
  final useCase = ref.read(projectsFilterUseCaseProvider);
  return useCase.collectTags(portfolio, allTag: allProjectsFilter);
});

final filteredProjectsProvider = Provider<List<Project>>((ref) {
  final portfolio = ref.watch(portfolioFutureProvider).valueOrNull;
  final filter = ref.watch(projectsFilterProvider);
  final useCase = ref.read(projectsFilterUseCaseProvider);
  return useCase.filterProjects(
    portfolio,
    filter,
    allTag: allProjectsFilter,
  );
});
