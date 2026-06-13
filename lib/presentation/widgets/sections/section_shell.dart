import 'package:flutter/material.dart';
import 'package:vivekdevfolio/presentation/widgets/section_header.dart';

class SectionShell extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Color sectionBorderColor;
  final Color accentGradientStart;
  final Color accentGradientEnd;
  final Color subtitleColor;

  const SectionShell({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.sectionBorderColor = const Color(0xFFE4E9F2),
    this.accentGradientStart = const Color(0xFF6366F1),
    this.accentGradientEnd = const Color(0xFFDB2777),
    this.subtitleColor = const Color(0xFF64748B),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pad = _sectionHorizontalPadding(constraints.maxWidth);
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 24),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: sectionBorderColor)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: title,
                    subtitle: subtitle,
                    accentGradientStart: accentGradientStart,
                    accentGradientEnd: accentGradientEnd,
                    subtitleColor: subtitleColor,
                  ),
                  const SizedBox(height: 12),
                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

double _sectionHorizontalPadding(double width) {
  if (width > 900) return 38;
  if (width > 600) return 16;
  return 4;
}
