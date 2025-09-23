import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vivek_portfolio/presentation/portfolio/providers/portfolio_providers.dart';
import 'package:vivek_portfolio/presentation/widgets/sections.dart';

class PortfolioPage extends ConsumerStatefulWidget {
  final String? initialSection;
  const PortfolioPage({super.key, this.initialSection});

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  final itemController = ItemScrollController();
  final positions = ItemPositionsListener.create();
  final sections = const [
    'About','Skills','Experience','Projects','Awards','Education','Certifications','Contact'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final target = widget.initialSection;
    if (target != null) {
      final idx = sections.indexOf(target);
      if (idx >= 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          itemController.scrollTo(index: idx, duration: const Duration(milliseconds: 350));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final portfolioAsync = ref.watch(portfolioFutureProvider);
    return portfolioAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (p) {
        return Scaffold(
          appBar: AppBar(
            title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.name),
              Text(p.title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
            ]),
            actions: [
              for (final id in sections)
                TextButton(
                  onPressed: () => itemController.scrollTo(index: sections.indexOf(id), duration: const Duration(milliseconds: 300)),
                  child: Text(id, style: const TextStyle(color: Colors.white70)),
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: ScrollablePositionedList.builder(
            itemCount: sections.length,
            itemScrollController: itemController,
            itemPositionsListener: positions,
            itemBuilder: (context, index) {
              final id = sections[index];
              return SectionShell(
                title: id,
                child: buildSection(id, p, ref),
              );
            },
          ),
        );
      },
    );
  }
}
