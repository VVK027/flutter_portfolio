import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';
import 'portfolio_providers.dart';

final projectsFilterProvider = StateProvider<String>((_) => 'All');

final filteredProjectsProvider = Provider.autoDispose<List<Project>>((ref) {
  final portfolio = ref.watch(portfolioFutureProvider).valueOrNull;
  final filter = ref.watch(projectsFilterProvider.select((s) => s));
  if (portfolio == null) return const [];
  if (filter == 'All') return portfolio.projects;
  return portfolio.projects.where((p) => p.tags.contains(filter)).toList(growable: false);
});
