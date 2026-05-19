import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivekdevfolio/data/repositories/asset_portfolio_repository.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/domain/repositories/portfolio_repository.dart';
import 'package:vivekdevfolio/domain/usecases/about_metrics_usecase.dart';
import 'package:vivekdevfolio/domain/usecases/contact_info_usecase.dart';
import 'package:vivekdevfolio/domain/usecases/projects_filter_usecase.dart';
import 'package:vivekdevfolio/domain/usecases/skill_categories_usecase.dart';

final portfolioRepositoryProvider = Provider<PortfolioRepository>(
  (ref) => const AssetPortfolioRepository(),
);

final aboutMetricsUseCaseProvider = Provider<AboutMetricsUseCase>(
  (ref) => const AboutMetricsUseCase(),
);

final contactInfoUseCaseProvider = Provider<ContactInfoUseCase>(
  (ref) => const ContactInfoUseCase(),
);

final skillCategoriesUseCaseProvider = Provider<SkillCategoriesUseCase>(
  (ref) => const SkillCategoriesUseCase(),
);

final projectsFilterUseCaseProvider = Provider<ProjectsFilterUseCase>(
  (ref) => const ProjectsFilterUseCase(),
);

final portfolioFutureProvider = FutureProvider<Portfolio>((ref) async {
  final repo = ref.read(portfolioRepositoryProvider);
  return repo.load();
});
