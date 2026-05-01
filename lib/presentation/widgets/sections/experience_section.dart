import 'package:flutter/material.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experience;
  const ExperienceSection({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experience
          .map(
            (m) => _RoleCard(
              title: '${m.role} — ${m.company}',
              meta: '${m.period} · ${m.location}',
              bullets: m.bullets,
            ),
          )
          .toList(),
    );
  }
}

class SimpleBulletsSection extends StatelessWidget {
  final List<String> items;
  const SimpleBulletsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return _Bullets(items: items);
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String meta;
  final List<String> bullets;
  const _RoleCard({
    required this.title,
    required this.meta,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B29) : scheme.surface,
        border: Border.all(
          color: isDark ? const Color(0xFF30384D) : scheme.outlineVariant,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(meta, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          _Bullets(items: bullets),
        ],
      ),
    );
  }
}

class _Bullets extends StatelessWidget {
  final List<String> items;
  const _Bullets({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (e) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• '),
                Expanded(child: Text(e)),
              ],
            ),
          )
          .toList(),
    );
  }
}
