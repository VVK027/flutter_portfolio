import 'package:vivekdevfolio/domain/entities/portfolio.dart';

abstract class PortfolioRepository {
  Future<Portfolio> load();
}
