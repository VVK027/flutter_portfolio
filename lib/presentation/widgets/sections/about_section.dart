import 'package:flutter/material.dart';
import 'package:vivekdevfolio/domain/entities/about_metrics.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
//import 'package:vivekdevfolio/presentation/widgets/sections/strengths_section.dart';

class AboutSection extends StatelessWidget {
  final List<String>? summary;
  final AboutMetrics metrics;
  final List<Strength> strengths;

  const AboutSection({
    super.key,
    required this.summary,
    required this.metrics,
    required this.strengths,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildSummary(summary, isMobile),
        //if (strengths.isNotEmpty) ...[
          // const SizedBox(height: 20),
          // Text(
          //   'What I Bring to the Table',
          //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
          //     fontWeight: FontWeight.w700,
          //     color: context.appColors.textPrimary,
          //   ),
          // ),
          // const SizedBox(height: 12),
          // StrengthsSection(strengths: strengths),
        //],
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: metrics.tiles
              .map(
                (tile) => _AboutStatTile(
                  value: '${tile.value}+',
                  label: tile.label,
                  accent: _accentColorFor(tile.accentKey),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

List<Widget> _buildSummary(List<String>? summary, bool isMobile) => (summary ?? [])
    .map(
      (s) => Padding(
        padding: EdgeInsets.only(bottom: isMobile ? 6 : 8),
        child: Builder(
          builder: (context) => Text(
            s,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.appColors.textSecondary,
              fontSize: isMobile ? 14 : null,
              height: isMobile ? 1.45 : null,
            ),
          ),
        ),
      ),
    )
    .toList();

Color _accentColorFor(String key) {
  switch (key) {
    case 'magenta':
      return const Color(0xFFFF66C7);
    case 'blueLight':
      return const Color(0xFF7EC8FF);
    case 'violet':
      return const Color(0xFFB177FF);
    case 'cyan':
      return const Color(0xFF00D6FF);
    default:
      return const Color(0xFF00D6FF);
  }
}

class _AboutStatTile extends StatelessWidget {
  final String value;
  final String label;
  final Color accent;
  const _AboutStatTile({
    required this.value,
    required this.label,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      constraints: const BoxConstraints(minWidth: 170),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [colors.statGradientStart, colors.statGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              height: 1,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colors.textMuted,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
