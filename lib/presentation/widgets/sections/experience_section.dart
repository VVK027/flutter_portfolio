import 'package:flutter/material.dart';
import 'package:viivekportfolio/core/theme/app_colors.dart';
import 'package:viivekportfolio/domain/entities/portfolio.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experience;
  const ExperienceSection({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < experience.length; i++)
          _RoleTimelineNode(
            experience: experience[i],
            isLast: i == experience.length - 1,
          ),
      ],
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

class _RoleTimelineNode extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const _RoleTimelineNode({
    required this.experience,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator column
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: colors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: colors.card, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: colors.accent.withValues(alpha: 0.4),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 140,
                color: colors.cardBorder,
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Experience Card
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.card,
              border: Border.all(color: colors.cardBorder),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${experience.company} — ${experience.role}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        experience.period,
                        style: TextStyle(
                          color: colors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  experience.location,
                  style: TextStyle(color: colors.textMuted, fontSize: 12),
                ),
                const SizedBox(height: 12),
                _Bullets(items: experience.bullets),
              ],
            ),
          ),
        ),
      ],
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
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Icon(Icons.circle, size: 5, color: colors.accent),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 13.5, color: colors.textSecondary, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
