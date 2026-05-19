class AboutMetrics {
  final List<AboutStatTileData> tiles;

  const AboutMetrics({required this.tiles});
}

class AboutStatTileData {
  final int value;
  final String label;
  final String accentKey;

  const AboutStatTileData({
    required this.value,
    required this.label,
    required this.accentKey,
  });
}
