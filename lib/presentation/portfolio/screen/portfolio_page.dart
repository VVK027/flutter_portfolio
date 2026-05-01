import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vivek_portfolio/application/portfolio/portfolio_sections.dart';
import 'package:vivek_portfolio/application/portfolio/providers/portfolio_providers.dart';
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
  static const sections = PortfolioSection.values;
  int _activeSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    positions.itemPositions.addListener(_syncActiveSectionFromScroll);
  }

  @override
  void dispose() {
    positions.itemPositions.removeListener(_syncActiveSectionFromScroll);
    super.dispose();
  }

  void _syncActiveSectionFromScroll() {
    final visible = positions.itemPositions.value
        .where((item) => item.itemTrailingEdge > 0 && item.itemLeadingEdge < 1)
        .toList();
    if (visible.isEmpty) return;
    visible.sort((a, b) => a.index.compareTo(b.index));
    final nextIndex = visible.first.index;
    if (nextIndex != _activeSectionIndex && mounted) {
      setState(() => _activeSectionIndex = nextIndex);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final target = widget.initialSection;
    if (target != null) {
      final idx = sections.indexWhere((section) => section.id == target);
      if (idx >= 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          itemController.scrollTo(
            index: idx,
            duration: const Duration(milliseconds: 350),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final portfolioAsync = ref.watch(portfolioFutureProvider);

    return portfolioAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (p) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final isDesktop = screenWidth > 900;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: isDesktop ? 76 : 64,
            titleSpacing: isDesktop ? 20 : 12,
            title: Row(
              children: [
                Container(
                  width: isDesktop ? 44 : 38,
                  height: isDesktop ? 44 : 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF2D3343),
                      width: 1.2,
                    ),
                  ),
                  child: ClipOval(
                    child: Transform.scale(
                      scale: 1.2,
                      child: Image.asset(
                        'assets/profile.jpeg',
                        fit: BoxFit.cover,
                        alignment: const Alignment(0, -0.2),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: isDesktop ? 12 : 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: isDesktop ? 24 : 20,
                        ),
                      ),
                      Text(
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontSize: isDesktop ? 13 : 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isDesktop)
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (final entry in sections.asMap().entries)
                              TextButton(
                                onPressed: () => itemController.scrollTo(
                                  index: entry.key,
                                  duration: const Duration(milliseconds: 300),
                                ),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                ),
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 160),
                                  style: TextStyle(
                                    color: entry.key == _activeSectionIndex
                                        ? Colors.white
                                        : Colors.white70,
                                    fontSize: 14,
                                    fontWeight: entry.key == _activeSectionIndex
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                  child: Text(entry.value.title),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.menu),
                    onSelected: (id) => itemController.scrollTo(
                      index: sections.indexWhere((section) => section.id == id),
                      duration: const Duration(milliseconds: 300),
                    ),
                    itemBuilder: (_) => [
                      for (final section in sections)
                        PopupMenuItem(
                          value: section.id,
                          child: Text(section.title),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final pad = constraints.maxWidth > 900
                  ? 48.0
                  : (constraints.maxWidth > 600 ? 24.0 : 8.0);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: pad),
                child: ScrollablePositionedList.builder(
                  itemCount: sections.length,
                  itemScrollController: itemController,
                  itemPositionsListener: positions,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return SectionShell(
                      title: section.title,
                      child: buildSection(section, p, ref),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
