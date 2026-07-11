import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivekdevfolio/presentation/portfolio/providers/projects_filter_provider.dart';
import 'package:vivekdevfolio/presentation/widgets/projects_sliver.dart';

class OpenSourceSection extends ConsumerWidget {
  const OpenSourceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(openSourceProjectsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'I am a strong believer in giving back to the community. Here are some of my open-source projects and contributions.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
        ProjectsSliver(items: items),
      ],
    );
  }
}
