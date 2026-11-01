import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viivekportfolio/presentation/portfolio/providers/projects_filter_provider.dart';
import 'package:viivekportfolio/core/theme/app_colors.dart';
import 'package:viivekportfolio/presentation/widgets/projects_sliver.dart';

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
        // Search bar for projects
        TextField(
          decoration: InputDecoration(
            hintText: 'Search projects by title, tech stack, or keyword...',
            prefixIcon: Icon(Icons.search, color: colors.accent),
            filled: true,
            fillColor: colors.card,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.chipBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.chipBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.accent, width: 2),
            ),
          ),
          onChanged: (value) =>
              ref.read(projectSearchQueryProvider.notifier).state = value,
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
        ProjectsSliver(items: items),
      ],
    );
  }
}
