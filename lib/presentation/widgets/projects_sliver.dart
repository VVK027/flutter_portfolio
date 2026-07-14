import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vvk_ui_kit/vvk_ui_kit.dart';
import 'package:vivekdevfolio/presentation/widgets/projects/project_card.dart';
import 'package:vivekdevfolio/presentation/widgets/projects/projects_carousel_layout.dart';

class ProjectsSliver extends StatefulWidget {
  final List<Project> items;
  const ProjectsSliver({super.key, required this.items});

  @override
  State<ProjectsSliver> createState() => _ProjectsSliverState();
}

class _ProjectsSliverState extends State<ProjectsSliver> {
  double? _cachedWidth;
  List<Project>? _cachedItems;
  ProjectsCarouselLayout? _cachedLayout;

  ProjectsCarouselLayout _layoutFor(double width) {
    if (_cachedLayout != null &&
        _cachedWidth == width &&
        identical(_cachedItems, widget.items)) {
      return _cachedLayout!;
    }
    _cachedWidth = width;
    _cachedItems = widget.items;
    return _cachedLayout = ProjectsCarouselLayout.forWidth(
      width: width,
      items: widget.items,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = _layoutFor(constraints.maxWidth);
        final cacheWidth = (layout.slotWidth *
                MediaQuery.devicePixelRatioOf(context))
            .round();

        return UISectionCarousel(
          pageCount: layout.pageCount,
          pageHeight: layout.pageHeight,
          pageBuilder: (context, pageIndex) {
            final slice =
                carouselPageSlice(widget.items, pageIndex, layout.perPage);
            return UICarouselRowPage<Project>(
              items: slice,
              itemsPerPage: layout.perPage,
              gap: layout.gap,
              itemBuilder: (_, project) => RepaintBoundary(
                child: ProjectCard(
                  project: project,
                  previewHeight: layout.previewHeight,
                  previewCacheWidth: cacheWidth,
                ),
              ),
            );
          },
          controlsColors: UICarouselControlsColors(
            navBackground: context.appColors.carouselNavBg,
            navBorder: context.appColors.carouselNavBorder,
            navBorderActive: context.appColors.carouselNavBorderActive,
            navIcon: context.appColors.carouselIcon,
            navIconDisabled: context.appColors.carouselIconDisabled,
            indicatorActive: context.appColors.carouselIndicatorActive,
            indicatorInactive: context.appColors.carouselIndicatorInactive,
            accent: context.appColors.accent,
          ),
        );
      },
    );
  }
}
