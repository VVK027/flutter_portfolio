import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vivekdevfolio/data/datasources/asset_portfolio_datasource.dart';
import 'package:vivekdevfolio/data/mappers/portfolio_mapper.dart';
import 'package:vivekdevfolio/data/models/portfolio_model.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/domain/repositories/portfolio_repository.dart';

PortfolioModel _parsePortfolioModel(String raw) {
  return PortfolioModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

class AssetPortfolioRepository implements PortfolioRepository {
  final PortfolioDataSource dataSource;

  const AssetPortfolioRepository({
    this.dataSource = const AssetPortfolioDataSource(),
  });

  @override
  Future<Portfolio> load() async {
    final raw = await dataSource.loadRawJson();
    final model = await compute(_parsePortfolioModel, raw);
    return PortfolioMapper.toEntity(model);
  }
}
