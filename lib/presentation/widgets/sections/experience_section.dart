import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experience;
  const ExperienceSection({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experience
          .map(
            (m) => _RoleCard(
              title: '${m.company} - ${m.role}',
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
    final colors = context.appColors;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border.all(color: colors.cardBorder),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            meta,
            style: TextStyle(color: colors.textMuted, fontSize: 12),
          ),
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
    final colors = context.appColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (e) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(color: colors.textMuted)),
                Expanded(
                  child: Text(
                    e,
                    style: TextStyle(fontSize: 14, color: colors.textSecondary),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
