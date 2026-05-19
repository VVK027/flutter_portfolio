import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';

class SectionShell extends StatelessWidget {
  final String title;
  final Widget child;
  final bool hideTitle;
  const SectionShell({
    super.key,
    required this.title,
    required this.child,
    this.hideTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pad = _sectionHorizontalPadding(constraints.maxWidth);
        final isMobile = constraints.maxWidth < 600;
        final colors = context.appColors;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 24),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colors.sectionBorder)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!hideTitle) ...[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: isMobile ? 24 : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

double _sectionHorizontalPadding(double width) {
  if (width > 900) return 38;
  if (width > 600) return 16;
  return 4;
}
