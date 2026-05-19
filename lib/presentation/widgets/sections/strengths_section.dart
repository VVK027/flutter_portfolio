import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class StrengthsSection extends StatelessWidget {
  final List<Strength> strengths;
  const StrengthsSection({super.key, required this.strengths});

  @override
  Widget build(BuildContext context) {
    if (strengths.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: strengths.map((s) => _StrengthItem(strength: s)).toList(),
    );
  }
}

class _StrengthItem extends StatelessWidget {
  final Strength strength;
  const _StrengthItem({required this.strength});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 14),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.accent,
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${strength.title}: ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: isMobile ? 16 : 17,
                      height: 1.5,
                    ),
                  ),
                  TextSpan(
                    text: strength.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.textSecondary,
                      fontSize: isMobile ? 15 : 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
