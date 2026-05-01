import 'package:flutter/material.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';

class SkillsSection extends StatelessWidget {
  final Skills? skills;
  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final categories = _buildSkillCategories(skills);
        final isMobile = c.maxWidth < 720;
        final cardWidth = isMobile ? c.maxWidth : ((c.maxWidth - 24) / 2);
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final category in categories)
              SizedBox(
                width: cardWidth,
                child: _SkillCategoryCard(category: category),
              ),
          ],
        );
      },
    );
  }
}

class _SkillCategory {
  final String title;
  final IconData icon;
  final List<String> items;
  final Color tint;
  const _SkillCategory({
    required this.title,
    required this.icon,
    required this.items,
    required this.tint,
  });
}

List<_SkillCategory> _buildSkillCategories(Skills? skills) {
  final allSkills = <String>{
    ...(skills?.core ?? const []),
    ...(skills?.additional ?? const []),
  };
  List<String> pick(List<String> priority) =>
      priority.where(allSkills.contains).toList();
  return [
    _SkillCategory(
      title: 'Mobile Development',
      icon: Icons.smartphone,
      tint: const Color(0xFF6BCBFF),
      items: pick([
        'Flutter',
        'React Native',
        'Android (Java, Kotlin)',
        'iOS (Swift)',
        'Dart',
      ]),
    ),
    _SkillCategory(
      title: 'Backend & Database',
      icon: Icons.storage_rounded,
      tint: const Color(0xFFCE93D8),
      items: pick([
        'Firebase',
        'REST APIs',
        'GraphQL',
        'SQLite',
        'MySQL',
        'Hive',
        'Isar',
      ]),
    ),
    _SkillCategory(
      title: 'Real-Time Features',
      icon: Icons.bolt_rounded,
      tint: const Color(0xFFFFD166),
      items: pick(['WebSockets', 'Agora SDK', 'BLE/Wi-Fi', 'Firebase']),
    ),
    _SkillCategory(
      title: 'Payment Systems',
      icon: Icons.credit_card_rounded,
      tint: const Color(0xFFA5D6A7),
      items: pick(['REST APIs', 'Firebase']),
    ),
    _SkillCategory(
      title: 'Programming Languages',
      icon: Icons.code_rounded,
      tint: const Color(0xFF90CAF9),
      items: pick([
        'Dart',
        'JavaScript',
        'TypeScript',
        'Android (Java, Kotlin)',
        'iOS (Swift)',
      ]),
    ),
    _SkillCategory(
      title: 'Tools & Platforms',
      icon: Icons.build_rounded,
      tint: const Color(0xFFB0BEC5),
      items: pick([
        'Jenkins',
        'Bitrise',
        'GitHub Actions',
        'GitHub',
        'GitLab',
        'Bitbucket',
        'JIRA',
        'Confluence',
      ]),
    ),
  ].where((e) => e.items.isNotEmpty).toList();
}

class _SkillCategoryCard extends StatelessWidget {
  final _SkillCategory category;
  const _SkillCategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF171B2A) : scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF343B50) : scheme.outlineVariant,
        ),
        boxShadow: isDark
            ? const []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
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
              Icon(category.icon, size: 18, color: category.tint),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: isDark ? Colors.white : scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.items
                .map(
                  (skill) => Chip(
                    label: Text(skill),
                    side: BorderSide(
                      color: isDark
                          ? const Color(0xFF3A425B)
                          : scheme.outlineVariant,
                    ),
                    backgroundColor: isDark
                        ? const Color(0xFF21273A)
                        : const Color(0xFFF3F4F8),
                    labelStyle: TextStyle(
                      color: isDark
                          ? const Color(0xFFE9EDF8)
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
