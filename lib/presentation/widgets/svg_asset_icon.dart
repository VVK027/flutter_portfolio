import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vivekdevfolio/presentation/widgets/svg_path_parser.dart';

/// Renders an SVG asset using a lightweight custom painter.
class SvgAssetIcon extends StatefulWidget {
  const SvgAssetIcon({
    super.key,
    required this.assetPath,
    this.size = 24,
    this.color,
  });

  final String assetPath;
  final double size;
  final Color? color;

  @override
  State<SvgAssetIcon> createState() => _SvgAssetIconState();
}

class _SvgAssetIconState extends State<SvgAssetIcon> {
  Path? _path;
  Object? _loadToken;

  @override
  void initState() {
    super.initState();
    _loadPath();
  }

  @override
  void didUpdateWidget(covariant SvgAssetIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _loadPath();
    }
  }

  Future<void> _loadPath() async {
    final token = Object();
    _loadToken = token;
    try {
      final svg = await rootBundle.loadString(widget.assetPath);
      final match = RegExp(r'd="([^"]+)"').firstMatch(svg);
      if (match == null || !mounted || _loadToken != token) return;
      setState(() => _path = parseSvgPathData(match.group(1)!));
    } catch (_) {
      if (!mounted || _loadToken != token) return;
      setState(() => _path = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = _path;
    final color = widget.color ?? IconTheme.of(context).color ?? Colors.white;

    if (path == null) {
      return SizedBox(width: widget.size, height: widget.size);
    }

    return CustomPaint(
      size: Size.square(widget.size),
      painter: _SvgAssetIconPainter(path: path, color: color),
    );
  }
}

class _SvgAssetIconPainter extends CustomPainter {
  const _SvgAssetIconPainter({required this.path, required this.color});

  final Path path;
  final Color color;

  static const _viewBox = Size(640, 640);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / _viewBox.width;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.save();
    canvas.scale(scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SvgAssetIconPainter oldDelegate) {
    return oldDelegate.path != path || oldDelegate.color != color;
  }
}
