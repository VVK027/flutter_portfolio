import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/presentation/extensions/portfolio_section_enum.dart';

class PortfolioDesktopNav extends StatelessWidget {
  final List<PortfolioSectionEnum> sections;
  final int activeSectionIndex;
  final ValueChanged<int> onSectionSelected;

  const PortfolioDesktopNav({
    super.key,
    required this.sections,
    required this.activeSectionIndex,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Flexible(
      child: Align(
        alignment: Alignment.centerRight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in sections.asMap().entries)
                if (!(entry.value == PortfolioSectionEnum.achievements ||
                    entry.value == PortfolioSectionEnum.education ||
                    entry.value == PortfolioSectionEnum.certifications))
                  TextButton(
                    onPressed: () => onSectionSelected(entry.key),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 140),
                      style: TextStyle(
                        color: entry.key == activeSectionIndex
                            ? colors.navActive
                            : colors.navInactive,
                        fontSize: 14,
                        fontWeight: entry.key == activeSectionIndex
                            ? FontWeight.w700
                            : FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                      child: Text(entry.value.title),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class PortfolioMobileNavMenu extends StatelessWidget {
  final List<PortfolioSectionEnum> sections;
  final ValueChanged<String> onSectionSelected;

  const PortfolioMobileNavMenu({
    super.key,
    required this.sections,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, color: context.appColors.textPrimary),
      onSelected: onSectionSelected,
      itemBuilder: (_) => [
        for (final section in sections)
          PopupMenuItem(value: section.id, child: Text(section.title)),
      ],
    );
  }
}
