import 'package:flutter/services.dart' show rootBundle;

abstract class PortfolioDataSource {
  Future<String> loadRawJson();
}

class AssetPortfolioDataSource implements PortfolioDataSource {
  final String assetPath;

  const AssetPortfolioDataSource({this.assetPath = 'assets/data.json'});

  @override
  Future<String> loadRawJson() => rootBundle.loadString(assetPath);
}
