import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';

/// Fixed 16:9 frame for project screenshots.
class ProjectPreviewFrame extends StatelessWidget {
  static const double aspectRatio = 16 / 9;

  final Widget child;
  final double? height;

  const ProjectPreviewFrame({
    super.key,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final frame = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.previewBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.previewBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );

    if (height != null) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: frame,
      );
    }

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: frame,
    );
  }
}

Widget projectPreviewImage(
  String imagePath, {
  required String fallbackTitle,
  BoxFit fit = BoxFit.cover,
}) {
  final trimmed = imagePath.trim();
  if (trimmed.isEmpty) {
    return Builder(
      builder: (context) => projectPreviewPlaceholder(context, fallbackTitle),
    );
  }

  final image = trimmed.startsWith('http://') || trimmed.startsWith('https://')
      ? Image.network(
          trimmed,
          fit: fit,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          filterQuality: FilterQuality.medium,
          errorBuilder: (context, _, _) =>
              projectPreviewPlaceholder(context, fallbackTitle),
        )
      : Image.asset(
          trimmed,
          fit: fit,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          filterQuality: FilterQuality.medium,
          errorBuilder: (context, _, _) =>
              projectPreviewPlaceholder(context, fallbackTitle),
        );

  return image;
}

Widget projectPreviewPlaceholder(BuildContext context, String projectName) {
  final colors = context.appColors;
  final initials = projectName
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty && w[0] == w[0].toUpperCase())
      .take(2)
      .map((w) => w[0])
      .join();

  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [colors.previewGradientStart, colors.previewGradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          initials,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: colors.previewAccent,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Icon(
          Icons.code_rounded,
          color: colors.previewIcon,
          size: 20,
        ),
      ],
    ),
  );
}
