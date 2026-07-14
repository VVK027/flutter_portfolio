import 'dart:ui';

import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/presentation/extensions/portfolio_section_enum.dart';
import 'package:vivekdevfolio/presentation/portfolio/providers/portfolio_providers.dart';
import 'package:vivekdevfolio/presentation/portfolio/widgets/portfolio_profile_header.dart';
import 'package:vivekdevfolio/presentation/portfolio/widgets/portfolio_section_nav.dart';
import 'package:vivekdevfolio/presentation/widgets/github_profile_view_counter.dart';
import 'package:vivekdevfolio/presentation/widgets/sections.dart';
import 'package:vvk_ui_kit/vvk_ui_kit.dart';
import 'package:vivekdevfolio/core/provider/app_theme_provider.dart';

import 'package:vivekdevfolio/presentation/portfolio/widgets/portfolio_shimmer_view.dart';

class PortfolioPage extends ConsumerStatefulWidget {
  final String? initialSection;
  const PortfolioPage({super.key, this.initialSection});

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  final itemController = ItemScrollController();
  final positions = ItemPositionsListener.create();
  static const sections = PortfolioSectionEnum.values;

  /// Active section is exposed as a [ValueListenable] so scroll updates only
  /// rebuild the nav, not the whole scaffold (app bar blur + section list).
  final ValueNotifier<int> _activeSectionIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    positions.itemPositions.addListener(_syncActiveSectionFromScroll);
    _precacheAssets();
  }

  void _precacheAssets() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/profile.jpeg'), context);
    });
  }

  @override
  void dispose() {
    positions.itemPositions.removeListener(_syncActiveSectionFromScroll);
    _activeSectionIndex.dispose();
    super.dispose();
  }

  void _syncActiveSectionFromScroll() {
    final visible = positions.itemPositions.value
        .where((item) => item.itemTrailingEdge > 0 && item.itemLeadingEdge < 1)
        .toList();
    if (visible.isEmpty) return;
    visible.sort((a, b) => a.index.compareTo(b.index));
    // ValueNotifier only notifies listeners when the value actually changes.
    _activeSectionIndex.value = visible.first.index;
  }

  bool _isDesktop(double width) => width > 900;

  double _toolbarHeight(bool isDesktop) => isDesktop ? 92 : 74;

  double _titleSpacing(bool isDesktop) => isDesktop ? 26 : 16;

  double _contentPaddingForWidth(double width) {
    if (width > 900) return 48;
    if (width > 600) return 24;
    return 8;
  }

  void _scrollToSectionIndex(int index) {
    itemController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _scrollToSectionId(String id) {
    final index = sections.indexWhere((section) => section.id == id);
    if (index >= 0) {
      _scrollToSectionIndex(index);
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
            duration: const Duration(milliseconds: 300),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final portfolioAsync = ref.watch(portfolioFutureProvider);
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = _isDesktop(width);

    return portfolioAsync.when(
      loading: () => const PortfolioShimmerView(),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (portfolio) => _PortfolioScaffold(
        portfolio: portfolio,
        isDesktop: isDesktop,
        toolbarHeight: _toolbarHeight(isDesktop),
        titleSpacing: _titleSpacing(isDesktop),
        contentPaddingForWidth: _contentPaddingForWidth,
        activeSectionIndex: _activeSectionIndex,
        itemController: itemController,
        positions: positions,
        onSectionIndexSelected: _scrollToSectionIndex,
        onSectionIdSelected: _scrollToSectionId,
        buildSection: (section) => buildSection(section, portfolio, ref),
      ),
    );
  }
}

class _PortfolioScaffold extends StatelessWidget {
  final Portfolio portfolio;
  final bool isDesktop;
  final double toolbarHeight;
  final double titleSpacing;
  final double Function(double width) contentPaddingForWidth;
  final ValueListenable<int> activeSectionIndex;
  final ItemScrollController itemController;
  final ItemPositionsListener positions;
  final ValueChanged<int> onSectionIndexSelected;
  final ValueChanged<String> onSectionIdSelected;
  final Widget Function(PortfolioSectionEnum section) buildSection;

  const _PortfolioScaffold({
    required this.portfolio,
    required this.isDesktop,
    required this.toolbarHeight,
    required this.titleSpacing,
    required this.contentPaddingForWidth,
    required this.activeSectionIndex,
    required this.itemController,
    required this.positions,
    required this.onSectionIndexSelected,
    required this.onSectionIdSelected,
    required this.buildSection,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Scaffold(
      backgroundColor: colors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: toolbarHeight,
        titleSpacing: titleSpacing,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.appBarGradientStart,
                    colors.appBarGradientEnd,
                  ],
                ),
                border: Border(
                  bottom: BorderSide(color: colors.appBarBorder, width: 0.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.shadow,
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            ),
          ),
        ),
        title: Center(
          child: Row(
            children: [
              PortfolioProfileHeader(
                portfolio: portfolio,
                isDesktop: isDesktop,
              ),
              if (isDesktop)
                ValueListenableBuilder<int>(
                  valueListenable: activeSectionIndex,
                  builder: (context, index, _) => PortfolioDesktopNav(
                    sections: PortfolioSectionEnum.values,
                    activeSectionIndex: index,
                    onSectionSelected: onSectionIndexSelected,
                  ),
                ),
              const SizedBox(width: 6),
              const _PortfolioThemeToggle(),
              if (!isDesktop) ...[
                const SizedBox(width: 4),
                PortfolioMobileNavMenu(
                  sections: PortfolioSectionEnum.values,
                  onSectionSelected: onSectionIdSelected,
                ),
              ],
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: contentPaddingForWidth(constraints.maxWidth),
                ),
                child: ScrollablePositionedList.builder(
                  physics: const ClampingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: PortfolioSectionEnum.values.length,
                  itemScrollController: itemController,
                  itemPositionsListener: positions,
                  itemBuilder: (context, index) {
                    final section = PortfolioSectionEnum.values[index];
                    return RepaintBoundary(
                      child: SectionShell(
                        title: section.title,
                        subtitle: section == PortfolioSectionEnum.reviews
                            ? 'Recommendations from people I have worked with.'
                            : null,
                        sectionBorderColor: colors.sectionBorder,
                        accentGradientStart: colors.accentGradientStart,
                        accentGradientEnd: colors.accentGradientEnd,
                        subtitleColor: colors.textMuted,
                        child: buildSection(section),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const Positioned(
            left: 0,
            top: 0,
            child: GitHubProfileViewCounter(),
          ),
        ],
      ),
    );
  }
}

/// Theme toggle isolated in its own [ConsumerWidget] so that watching
/// [themeModeProvider] rebuilds only the button, not the whole app bar.
class _PortfolioThemeToggle extends ConsumerWidget {
  const _PortfolioThemeToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    return UIThemeToggleButton(
      themeMode: ref.watch(themeModeProvider),
      onThemeModeChanged: (mode) =>
          ref.read(themeModeProvider.notifier).state = mode,
      tooltipLightMode: 'Switch to light mode',
      tooltipDarkMode: 'Switch to dark mode',
      size: 32,
      backgroundColor: colors.chipBackground,
      foregroundColor: colors.textPrimary,
      borderColor: colors.cardBorder,
    );
  }
}
