import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:viivekportfolio/data/datasources/asset_portfolio_datasource.dart';
import 'package:viivekportfolio/data/mappers/portfolio_mapper.dart';
import 'package:viivekportfolio/data/models/portfolio_model.dart';
import 'package:viivekportfolio/domain/entities/portfolio.dart';
import 'package:viivekportfolio/domain/repositories/portfolio_repository.dart';

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
    try {
      final raw = await dataSource.loadRawJson();
      if (raw.isEmpty) {
        throw Exception('Portfolio data is empty');
      }
      final model = await compute(_parsePortfolioModel, raw);
      return PortfolioMapper.toEntity(model);
    } catch (e, stackTrace) {
      debugPrint('Error loading portfolio: $e');
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }
}
