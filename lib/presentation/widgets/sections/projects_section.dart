import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivek_portfolio/application/portfolio/providers/projects_filter_provider.dart';
import 'package:vivek_portfolio/presentation/widgets/projects_sliver.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(projectTagsProvider);
    final filter = ref.watch(projectsFilterProvider);
    final items = ref.watch(filteredProjectsProvider);

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
