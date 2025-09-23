import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivek_portfolio/data/asset_portfolio_repository.dart';
import 'package:vivek_portfolio/data/portfolio_repository.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';

final portfolioRepositoryProvider = Provider<PortfolioRepository>(
  (ref) => const AssetPortfolioRepository(),
);

final portfolioFutureProvider = FutureProvider<Portfolio>((ref) async {
  final repo = ref.read(portfolioRepositoryProvider);
  return repo.load();
});
