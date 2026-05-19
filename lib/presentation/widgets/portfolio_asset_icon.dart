import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vivekdevfolio/presentation/widgets/svg_path_parser.dart';

/// Brand icons shipped under [assets/icons].
enum PortfolioIcon {
  linkedin('assets/icons/linkedin.svg'),
  github('assets/icons/github.svg'),
  facebook('assets/icons/facebook-f.svg'),
  whatsapp('assets/icons/whatsapp.svg');

  const PortfolioIcon(this.assetPath);
  final String assetPath;
}

/// Renders an SVG from [assets/icons] using a lightweight custom painter.
class PortfolioAssetIcon extends StatefulWidget {
  const PortfolioAssetIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color,
  });

  final PortfolioIcon icon;
  final double size;
  final Color? color;

  @override
  State<PortfolioAssetIcon> createState() => _PortfolioAssetIconState();
}

class _PortfolioAssetIconState extends State<PortfolioAssetIcon> {
  Path? _path;
  Object? _loadToken;

  @override
  void initState() {
    super.initState();
    _loadPath();
  }

  @override
  void didUpdateWidget(covariant PortfolioAssetIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.icon != widget.icon) {
      _loadPath();
    }
  }

  Future<void> _loadPath() async {
    final token = Object();
    _loadToken = token;
    try {
      final svg = await rootBundle.loadString(widget.icon.assetPath);
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
      painter: _PortfolioIconPainter(path: path, color: color),
    );
  }
}

class _PortfolioIconPainter extends CustomPainter {
  const _PortfolioIconPainter({required this.path, required this.color});

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
  bool shouldRepaint(covariant _PortfolioIconPainter oldDelegate) {
    return oldDelegate.path != path || oldDelegate.color != color;
  }
}
