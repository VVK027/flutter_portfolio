import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vivek_portfolio/domain/portfolio_models.dart';
import 'package:vivek_portfolio/domain/repositories/portfolio_repository.dart';

Portfolio _parsePortfolio(String raw) {
  return Portfolio.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

class AssetPortfolioRepository implements PortfolioRepository {
  final String assetPath;
  const AssetPortfolioRepository({this.assetPath = 'assets/data.json'});

  @override
  Future<Portfolio> load() async {
    final raw = await rootBundle.loadString(assetPath);
    return compute(_parsePortfolio, raw);
  }
}
