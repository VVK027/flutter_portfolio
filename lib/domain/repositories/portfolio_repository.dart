import 'package:vivek_portfolio/domain/portfolio_models.dart';

abstract class PortfolioRepository {
  Future<Portfolio> load();
}
