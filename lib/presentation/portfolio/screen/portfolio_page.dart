import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
//import 'package:vivek_portfolio/core/provider/app_theme_provider.dart';
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
  static const sections = [
    'About', 'Skills', 'Experience', 'Projects', 'Awards', 'Education', 'Certifications', 'Contact'
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
            automaticallyImplyLeading: false,
            title: Align(
              alignment: Alignment.centerLeft, // Always left-aligned
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    p.title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            actions: [
              // Consumer(builder: (context, ref, _) {
              //   final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
              //   return Switch(
              //     value: isDark,
              //     onChanged: (v) {
              //       ref.read(themeModeProvider.notifier)
              //           .state = v ? ThemeMode.dark : ThemeMode.light;
              //     },
              //     activeThumbColor: Colors.blueAccent,
              //     inactiveThumbColor: Colors.yellow,
              //   );
              // }),
            ],
            flexibleSpace: PreferredSize( // Use flexibleSpace for live resize
              preferredSize: const Size.fromHeight(64),
              child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final id in sections)
                          TextButton(
                            onPressed: () => itemController.scrollTo(index: sections.indexOf(id),
                              duration: const Duration(milliseconds: 300),
                            ),
                            child: Text(id, style: const TextStyle(color: Colors.white70)),
                          ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton<String>(
                      icon: const Icon(Icons.menu),
                      onSelected: (id) => itemController.scrollTo(
                        index: sections.indexOf(id),
                        duration: const Duration(milliseconds: 300),
                      ),
                      itemBuilder: (_) => [
                        for (final id in sections)
                          PopupMenuItem(value: id, child: Text(id)),
                      ],
                    ),
                  );
                }
              }),
            ),
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            final pad = constraints.maxWidth > 900 ? 48.0 : (constraints.maxWidth > 600 ? 24.0 : 8.0);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: pad),
              child: ScrollablePositionedList.builder(
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
          }),
        );
      },
    );
  }
}
