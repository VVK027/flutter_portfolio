import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivekdevfolio/presentation/portfolio/providers/projects_filter_provider.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/presentation/widgets/projects_sliver.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(projectTagsProvider);
    final filter = ref.watch(projectsFilterProvider);
    final items = ref.watch(filteredProjectsProvider);
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags
              .map(
                (t) => FilterChip(
                  label: Text(t),
                  selected: filter == t,
                  selectedColor: colors.filterChipSelected,
                  backgroundColor: colors.filterChipUnselected,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: filter == t ? Colors.white : colors.chipLabel,
                  ),
                  side: BorderSide(
                    color: filter == t ? colors.accent : colors.chipBorder,
                  ),
                  onSelected: (_) =>
                      ref.read(projectsFilterProvider.notifier).state = t,
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        ProjectsSliver(items: items),
      ],
    );
  }
}
