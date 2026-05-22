import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/presentation/widgets/carousel/carousel_layout.dart';
import 'package:vivekdevfolio/presentation/widgets/project_preview.dart';
import 'package:vivekdevfolio/presentation/widgets/projects/project_card_view_data.dart';

/// Precomputed carousel dimensions for the projects section.
class ProjectsCarouselLayout {
  final int perPage;
  final int pageCount;
  final double gap;
  final double slotWidth;
  final double previewHeight;
  final double pageHeight;

  const ProjectsCarouselLayout({
    required this.perPage,
    required this.pageCount,
    required this.gap,
    required this.slotWidth,
    required this.previewHeight,
    required this.pageHeight,
  });

  factory ProjectsCarouselLayout.forWidth({
    required double width,
    required List<Project> items,
  }) {
    final perPage = itemsPerPageForWidth(
      width,
      mobile: 1,
      tablet: 2,
      desktop: 2,
    );
    final gap = width < 600 ? 0.0 : 12.0;
    final slotWidth = (width - 4 - gap * (perPage - 1)) / perPage;
    final previewHeight = slotWidth / ProjectPreviewFrame.aspectRatio;
    final maxFooterHeight = maxProjectCardFooterHeight(
      items.map((p) => p.tags),
      cardWidth: slotWidth,
    );

    return ProjectsCarouselLayout(
      perPage: perPage,
      pageCount: carouselPageCount(items.length, perPage),
      gap: gap,
      slotWidth: slotWidth,
      previewHeight: previewHeight,
      pageHeight:
          previewHeight + maxFooterHeight - projectCardPageBottomInset,
    );
  }
}
