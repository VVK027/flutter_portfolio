import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';
import 'package:vivek_portfolio/presentation/portfolio/providers/projects_filter_provider.dart';

class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double web = 1300;
  static int columnsFor(double width) {
    if (width < mobile) return 1;
    if (width < tablet) return 2;
    if (width < web) return 3;
    return 4;
  }
}

class ProjectsSliver extends ConsumerWidget {
  final List<Project> all;
  const ProjectsSliver({super.key, required this.all});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(projectsFilterProvider);
    final items = filter == 'All'
        ? all
        : all.where((p) => p.tags.contains(filter)).toList(growable: false);

    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final cols = Breakpoints.columnsFor(constraints.crossAxisExtent);
        final aspect = constraints.crossAxisExtent < 600 ? 1.8 :
        constraints.crossAxisExtent < 1000 ? 1.8 : 2.0;
        return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 8,      // reduce from 12
              mainAxisSpacing: 8,       // reduce from 12
              childAspectRatio: aspect, // set lower, e.g. 1.2, for mobile 1.0
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, i) => _ProjectCard(project: items[i]),
              childCount: items.length,
            ),
          ),
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F121A),
        border: Border.all(color: const Color(0xFF1E2330)),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(project.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(
            project.desc,
            style: const TextStyle(color: Colors.grey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final t in project.tags)
                Chip(label: Text(t), visualDensity: VisualDensity.compact),
            ],
          ),
        ],
      ),
    );
  }
}
