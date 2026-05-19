import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';

class CarouselControls extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final bool loop;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final ValueChanged<int> onPageSelected;

  const CarouselControls({
    super.key,
    required this.pageCount,
    required this.currentPage,
    this.loop = false,
    required this.onPrevious,
    required this.onNext,
    required this.onPageSelected,
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
        ),
        const SizedBox(width: 16),
        CarouselPageIndicators(
          pageCount: pageCount,
          currentPage: currentPage,
          onPageSelected: onPageSelected,
        ),
        const SizedBox(width: 16),
        CarouselNavButton(
          icon: Icons.chevron_right_rounded,
          enabled: canGoForward,
          highlighted: canGoForward,
          onPressed: canGoForward ? onNext : null,
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

  const CarouselNavButton({
    super.key,
    required this.icon,
    required this.enabled,
    required this.highlighted,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
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
            color: colors.carouselNavBg,
            border: Border.all(
              color: highlighted
                  ? colors.carouselNavBorderActive
                  : colors.carouselNavBorder,
              width: 1.2,
            ),
            boxShadow: highlighted
                ? [
                    BoxShadow(
                      color: colors.accent.withValues(alpha: 0.25),
                      blurRadius: 12,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: enabled ? colors.carouselIcon : colors.carouselIconDisabled,
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

  const CarouselPageIndicators({
    super.key,
    required this.pageCount,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
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
                    ? colors.carouselIndicatorActive
                    : colors.carouselIndicatorInactive,
              ),
            ),
          ),
        );
      }),
    );
  }
}
