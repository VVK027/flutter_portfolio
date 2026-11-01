import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viivekportfolio/presentation/portfolio/providers/projects_filter_provider.dart';
import 'package:viivekportfolio/presentation/widgets/projects_sliver.dart';
import 'package:viivekportfolio/core/theme/app_colors.dart';

class OpenSourceSection extends ConsumerWidget {
  const OpenSourceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openSourceProjects = ref.watch(openSourceProjectsProvider);
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.cardBorder),
          ),
          child: Row(
            children: [
              Icon(Icons.code_rounded, color: colors.accent, size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Open Source Contributions & Packages',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Packages, plugins, and repositories built for the developer community with clean architecture and robust test coverage.',
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ProjectsSliver(items: openSourceProjects),
      ],
    );
  }
}
