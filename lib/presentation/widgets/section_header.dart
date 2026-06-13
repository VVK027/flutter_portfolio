import 'package:flutter/material.dart';

/// Shared section title styling so every portfolio section aligns consistently.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? accentGradientStart;
  final Color? accentGradientEnd;
  final Color? subtitleColor;
  final Color? titleColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.accentGradientStart = const Color(0xFF6366F1),
    this.accentGradientEnd = const Color(0xFFDB2777),
    this.subtitleColor = const Color(0xFF64748B),
    this.titleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontSize: isMobile ? 24 : 27,
      fontWeight: FontWeight.w700,
      height: 1.15,
      letterSpacing: -0.2,
      color: titleColor,
    );

    final titleWidget = Text(title, style: titleStyle);
    final gradientStart = accentGradientStart;
    final gradientEnd = accentGradientEnd;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (gradientStart != null && gradientEnd != null)
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(
              colors: [gradientStart, gradientEnd],
            ).createShader(bounds),
            child: titleWidget,
          )
        else
          titleWidget,
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: subtitleColor,
              fontSize: isMobile ? 13 : 14,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}
