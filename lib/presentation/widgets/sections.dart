import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';
import 'package:vivek_portfolio/presentation/portfolio/providers/projects_filter_provider.dart';
import 'package:vivek_portfolio/presentation/widgets/projects_sliver.dart';

class SectionShell extends StatelessWidget {
  final String title;
  final Widget child;
  const SectionShell({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double pad = constraints.maxWidth > 900 ? 38 : (constraints.maxWidth > 600 ? 16 : 4);
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: pad, vertical: 24),
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFF20232D)))),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
      );
    });
  }
}

// Helper for summary paragraphs
List<Widget> buildSummary(List<String>? summary) => (summary ?? [])
    .map((s) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(s)))
    .toList();

Widget buildSection(String id, Portfolio p, WidgetRef ref) {
  switch (id) {
    case 'About':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...buildSummary(p.summary),
          Text('Location: ${p.location}', style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      );
    case 'Skills':
      return LayoutBuilder(builder: (context, c) {
        final narrow = c.maxWidth < 700;
        // On mobile, vertical stack. On tablet/web, side-by-side panels.
        return Wrap(
          spacing: narrow ? 0 : 20,
          runSpacing: 16,
          alignment: WrapAlignment.start,
          children: [
            SizedBox(
              width: narrow ? double.infinity : c.maxWidth/2-12,
              child: _Panel(
                title: 'Core',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (p.skills?.core ?? []).map((e) => Chip(label: Text(e))).toList(),
                ),
              ),
            ),
            SizedBox(
              width: narrow ? double.infinity : c.maxWidth/2-12,
              child: _Panel(
                title: 'Additional',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (p.skills?.additional ?? []).map((e) => Chip(label: Text(e))).toList(),
                ),
              ),
            ),
          ],
        );
      });
    case 'Experience':
      return Column(
        children: p.experience
            .map((m) => _RoleCard(
          title: '${m.role} — ${m.company}',
          meta: '${m.period} · ${m.location}',
          bullets: m.bullets,
        )).toList(),
      );
    case 'Projects':
      final tags = {'All'}..addAll(p.projects.expand((e) => e.tags));
      final filter = ref.watch(projectsFilterProvider);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: tags.map((t) =>
                FilterChip(
                  label: Text(t),
                  selected: filter == t,
                  onSelected: (_) => ref.read(projectsFilterProvider.notifier).state = t,
                )
            ).toList(),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 700,
            child: CustomScrollView(
              slivers: [
                ProjectsSliver(all: p.projects),
              ],
            ),
          ),
        ],
      );
    case 'Awards':
      return _Bullets(items: p.awards);
    case 'Education':
      return _Bullets(items: p.education);
    case 'Certifications':
      return _Bullets(items: p.certifications);
    case 'Contact':
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(p.contact.note),
          const SizedBox(height: 8),
          const Text('Add preferred contact channels in assets/data.json.'),
        ],
      );
    default:
      return const SizedBox.shrink();
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Widget child;
  const _Panel({required this.title, required this.child});
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
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String meta;
  final List bullets;
  const _RoleCard({required this.title, required this.meta, required this.bullets});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F121A),
        border: Border.all(color: const Color(0xFF1E2330)),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
  final List items;
  const _Bullets({required this.items});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((e) =>
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• '),
              Expanded(child: Text(e)),
            ],
          )
      ).toList(),
    );
  }
}
