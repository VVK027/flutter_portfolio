import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/core/theme/app_fonts.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/presentation/extensions/review_extensions.dart';
import 'package:vivekdevfolio/presentation/widgets/section_carousel.dart';

class ReviewsSection extends StatelessWidget {
  final List<Review> reviews;
  const ReviewsSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final perPage = itemsPerPageForWidth(width, mobile: 1, tablet: 2, desktop: 2);
        final pages = carouselPageCount(reviews.length, perPage);
        final cardHeight = width < 600 ? 260.0 : 240.0;
        final gap = width < 600 ? 0.0 : 16.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ReviewsSectionHeader(),
            const SizedBox(height: 16),
            SectionCarousel(
              pageCount: pages,
              pageHeight: cardHeight,
              autoPlay: pages > 1,
              autoPlayInterval: const Duration(seconds: 2),
              pageBuilder: (context, pageIndex) {
                final slice = carouselPageSlice(reviews, pageIndex, perPage);
                return CarouselRowPage<Review>(
                  items: slice,
                  itemsPerPage: perPage,
                  gap: gap,
                  itemBuilder: (_, review) => _ReviewCard(review: review),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ReviewsSectionHeader extends StatelessWidget {
  const _ReviewsSectionHeader();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            colors: [colors.accentGradientStart, colors.accentGradientEnd],
          ).createShader(bounds),
          child: Text(
            'Reviews',
            style: TextStyle(
              fontFamily: AppFonts.family,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 30 : 36,
              height: 1.1,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Recommendations from people I have worked with.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.textMuted,
            fontSize: isMobile ? 13 : 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StarRating(rating: review.rating),
              Icon(
                Icons.format_quote_rounded,
                size: 32,
                color: colors.quoteIcon,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              review.quote,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
                fontStyle: FontStyle.italic,
                height: 1.45,
                fontSize: 14,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: colors.avatarBackground,
                child: Text(
                  review.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review.subtitle,
                      style: TextStyle(
                        color: colors.textMuted,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final int rating;
  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final filled = index < rating;
        return Padding(
          padding: EdgeInsets.only(right: index == 4 ? 0 : 3),
          child: Icon(
            filled ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 17,
            color: filled ? colors.starFilled : colors.starEmpty,
          ),
        );
      }),
    );
  }
}
