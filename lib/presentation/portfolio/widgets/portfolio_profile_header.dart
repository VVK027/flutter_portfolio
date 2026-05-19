import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class PortfolioProfileHeader extends StatelessWidget {
  final Portfolio portfolio;
  final bool isDesktop;

  const PortfolioProfileHeader({
    super.key,
    required this.portfolio,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Expanded(
      child: Row(
        children: [
          Container(
            width: isDesktop ? 56 : 48,
            height: isDesktop ? 56 : 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.profileBorder, width: 1.4),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow,
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: Transform.scale(
                scale: 1.11,
                child: Image.asset(
                  'assets/profile.jpeg',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.1),
                ),
              ),
            ),
          ),
          SizedBox(width: isDesktop ? 16 : 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  portfolio.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: isDesktop ? 28 : 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: isDesktop ? 2 : 1),
                Text(
                  portfolio.title,
                  maxLines: isDesktop ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.textMuted,
                    fontSize: isDesktop ? 14 : 12,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
