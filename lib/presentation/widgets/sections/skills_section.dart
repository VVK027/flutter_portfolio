import 'package:flutter/material.dart';
import 'package:vivekdevfolio/domain/entities/skill_category.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';

class SkillsSection extends StatelessWidget {
  final List<SkillCategory> categories;
  const SkillsSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, c) {
        final layout = _SkillsLayoutSpec.fromWidth(c.maxWidth);
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final category in categories)
              SizedBox(
                width: layout.cardWidth,
                child: _SkillCategoryCard(category: category),
              ),
          ],
        );
      },
    );
  }
}

class _SkillsLayoutSpec {
  final double cardWidth;
  const _SkillsLayoutSpec({required this.cardWidth});

  factory _SkillsLayoutSpec.fromWidth(double width) {
    final isMobile = width < 720;
    return _SkillsLayoutSpec(
      cardWidth: isMobile ? width : ((width - 24) / 2),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  final SkillCategory category;
  const _SkillCategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.cardBorder),
        boxShadow: isDark
            ? const []
            : [
                BoxShadow(
                  color: colors.shadow,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _iconFor(category.iconKey),
                size: 18,
                color: _tintColorFor(category.tintKey),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.items
                .map(
                  (skill) => Chip(
                    label: Text(skill),
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 2.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 2.0,
                    ),
                    side: BorderSide(color: colors.chipBorder),
                    backgroundColor: colors.chipBackground,
                    labelStyle: TextStyle(color: colors.chipLabel),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

IconData _iconFor(String iconKey) {
  switch (iconKey) {
    case 'smartphone':
      return Icons.smartphone;
    case 'storage':
      return Icons.storage_rounded;
    case 'bolt':
      return Icons.bolt_rounded;
    case 'payment':
      return Icons.credit_card_rounded;
    case 'code':
      return Icons.code_rounded;
    case 'tools':
      return Icons.build_rounded;
    case 'security':
      return Icons.shield_rounded;
    case 'cloud':
      return Icons.cloud_rounded;
    case 'architecture':
      return Icons.account_tree_rounded;
    case 'cicd':
      return Icons.rocket_launch_rounded;
    case 'ai':
      return Icons.auto_awesome_rounded;
    default:
      return Icons.category_rounded;
  }
}

Color _tintColorFor(String tintKey) {
  switch (tintKey) {
    case 'blue':
      return const Color(0xFF6BCBFF);
    case 'purple':
      return const Color(0xFFCE93D8);
    case 'amber':
      return const Color(0xFFFFD166);
    case 'green':
      return const Color(0xFFA5D6A7);
    case 'blueSoft':
      return const Color(0xFF90CAF9);
    case 'slate':
      return const Color(0xFFB0BEC5);
    case 'red':
      return const Color(0xFFEF9A9A);
    case 'teal':
      return const Color(0xFF80CBC4);
    default:
      return const Color(0xFF90CAF9);
  }
}
