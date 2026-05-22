import 'package:flutter/material.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/presentation/widgets/projects/project_card.dart';
import 'package:vivekdevfolio/presentation/widgets/projects/projects_carousel_layout.dart';
import 'package:vivekdevfolio/presentation/widgets/section_carousel.dart';

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

        return SectionCarousel(
          pageCount: layout.pageCount,
          pageHeight: layout.pageHeight,
          pageBuilder: (context, pageIndex) {
            final slice =
                carouselPageSlice(widget.items, pageIndex, layout.perPage);
            return CarouselRowPage<Project>(
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
        );
      },
    );
  }
}
