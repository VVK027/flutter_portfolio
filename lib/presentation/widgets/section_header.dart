import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';

/// Shared section title styling so every portfolio section aligns consistently.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontSize: isMobile ? 24 : 27,
      fontWeight: FontWeight.w700,
      height: 1.15,
      letterSpacing: -0.2,
      color: Colors.white,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            colors: [colors.accentGradientStart, colors.accentGradientEnd],
          ).createShader(bounds),
          child: Text(title, style: titleStyle),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.textMuted,
              fontSize: isMobile ? 13 : 14,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}
