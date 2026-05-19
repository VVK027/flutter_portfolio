import 'package:flutter/material.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/presentation/widgets/projects/project_card.dart';
import 'package:vivekdevfolio/presentation/widgets/projects/project_card_view_data.dart';
import 'package:vivekdevfolio/presentation/widgets/project_preview.dart';
import 'package:vivekdevfolio/presentation/widgets/section_carousel.dart';

class ProjectsSliver extends StatelessWidget {
  final List<Project> items;
  const ProjectsSliver({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final perPage = itemsPerPageForWidth(
          width,
          mobile: 1,
          tablet: 2,
          desktop: 2,
        );
        final pages = carouselPageCount(items.length, perPage);
        final gap = width < 600 ? 0.0 : 12.0;
        final cardWidth = carouselCardWidth(width, itemsPerPage: perPage, gap: gap);
        final previewHeight = cardWidth / ProjectPreviewFrame.aspectRatio;
        final pageHeight =
            previewHeight + projectCardMaxFooterHeight + projectCardPadding;

        return SectionCarousel(
          pageCount: pages,
          pageHeight: pageHeight,
          pageBuilder: (context, pageIndex) {
            final slice = carouselPageSlice(items, pageIndex, perPage);
            return CarouselRowPage<Project>(
              items: slice,
              itemsPerPage: perPage,
              gap: gap,
              itemBuilder: (_, project) => ProjectCard(
                project: project,
                previewHeight: previewHeight,
              ),
            );
          },
        );
      },
    );
  }
}
