import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';
import 'package:vivek_portfolio/presentation/portfolio/providers/projects_filter_provider.dart';

class Breakpoints {
  static const double small = 700;
  static const double medium = 1100;
  static int columnsFor(double w) => w < small ? 1 : (w < medium ? 2 : 3);
}

class ProjectsSliver extends ConsumerWidget {
  final List<Project> all;
  const ProjectsSliver({super.key, required this.all});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(projectsFilterProvider);
    final items = filter == 'All' ? all : all.where((p) => p.tags.contains(filter)).toList(growable: false);
    return SliverLayoutBuilder(builder: (context, constraints) {
      final cols = Breakpoints.columnsFor(constraints.crossAxisExtent);
      return SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.8,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, i) => _ProjectCard(items[i]),
            childCount: items.length,
          ),
        ),
      );
    });
  }
}

class _ProjectCard extends StatelessWidget {
  final Project p;
  const _ProjectCard(this.p);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F121A),
        border: Border.all(color: const Color(0xFF1E2330)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Text(p.desc, style: const TextStyle(color: Colors.grey)),
        const Spacer(),
        Wrap(spacing: 6, runSpacing: 6, children: [
          for (final t in p.tags) Chip(label: Text(t), visualDensity: VisualDensity.compact),
        ]),
      ]),
    );
  }
}
