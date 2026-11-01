import 'package:viivekportfolio/domain/entities/portfolio.dart';

abstract class PortfolioRepository {
  Future<Portfolio> load();
}
