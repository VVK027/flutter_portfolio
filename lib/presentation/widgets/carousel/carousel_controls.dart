import 'package:flutter/material.dart';

@immutable
class CarouselControlsColors {
  final Color navBackground;
  final Color navBorder;
  final Color navBorderActive;
  final Color navIcon;
  final Color navIconDisabled;
  final Color indicatorActive;
  final Color indicatorInactive;
  final Color accent;

  const CarouselControlsColors({
    this.navBackground = const Color(0xFFFFFFFF),
    this.navBorder = const Color(0xFFCBD5E1),
    this.navBorderActive = const Color(0xFF6366F1),
    this.navIcon = const Color(0xFF334155),
    this.navIconDisabled = const Color(0xFF94A3B8),
    this.indicatorActive = const Color(0xFF6366F1),
    this.indicatorInactive = const Color(0xFFCBD5E1),
    this.accent = const Color(0xFF4F46E5),
  });
}

class CarouselControls extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final bool loop;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final ValueChanged<int> onPageSelected;
  final CarouselControlsColors? colors;

  const CarouselControls({
    super.key,
    required this.pageCount,
    required this.currentPage,
    this.loop = false,
    required this.onPrevious,
    required this.onNext,
    required this.onPageSelected,
    this.colors = const CarouselControlsColors(),
  });

  @override
  Widget build(BuildContext context) {
    final canGoBack = loop || currentPage > 0;
    final canGoForward = loop || currentPage < pageCount - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselNavButton(
          icon: Icons.chevron_left_rounded,
          enabled: canGoBack,
          highlighted: canGoBack,
          onPressed: canGoBack ? onPrevious : null,
          colors: colors,
        ),
        const SizedBox(width: 16),
        CarouselPageIndicators(
          pageCount: pageCount,
          currentPage: currentPage,
          onPageSelected: onPageSelected,
          colors: colors,
        ),
        const SizedBox(width: 16),
        CarouselNavButton(
          icon: Icons.chevron_right_rounded,
          enabled: canGoForward,
          highlighted: canGoForward,
          onPressed: canGoForward ? onNext : null,
          colors: colors,
        ),
      ],
    );
  }
}

class CarouselNavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final bool highlighted;
  final VoidCallback? onPressed;
  final CarouselControlsColors? colors;

  const CarouselNavButton({
    super.key,
    required this.icon,
    required this.enabled,
    required this.highlighted,
    required this.onPressed,
    this.colors = const CarouselControlsColors(),
  });

  @override
  Widget build(BuildContext context) {
    final palette = colors ?? const CarouselControlsColors();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: palette.navBackground,
            border: Border.all(
              color: highlighted ? palette.navBorderActive : palette.navBorder,
              width: 1.2,
            ),
            boxShadow: highlighted
                ? [
                    BoxShadow(
                      color: palette.accent.withValues(alpha: 0.25),
                      blurRadius: 12,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: enabled ? palette.navIcon : palette.navIconDisabled,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class CarouselPageIndicators extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final ValueChanged<int> onPageSelected;
  final CarouselControlsColors? colors;

  const CarouselPageIndicators({
    super.key,
    required this.pageCount,
    required this.currentPage,
    required this.onPageSelected,
    this.colors = const CarouselControlsColors(),
  });

  @override
  Widget build(BuildContext context) {
    final palette = colors ?? const CarouselControlsColors();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : 8),
          child: GestureDetector(
            onTap: () => onPageSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: isActive ? 28 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isActive
                    ? palette.indicatorActive
                    : palette.indicatorInactive,
              ),
            ),
          ),
        );
      }),
    );
  }
}
