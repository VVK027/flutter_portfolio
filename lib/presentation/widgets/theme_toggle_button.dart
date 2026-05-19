import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivekdevfolio/core/provider/app_theme_provider.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';

/// Compact theme switch — moon for dark mode, sun for light mode.
class ThemeToggleButton extends ConsumerWidget {
  final double size;

  const ThemeToggleButton({super.key, this.size = 34});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final isDark = mode == ThemeMode.dark;
    final colors = context.appColors;

    return Tooltip(
      message: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: IconButton(
        onPressed: () {
          ref.read(themeModeProvider.notifier).state =
              isDark ? ThemeMode.light : ThemeMode.dark;
        },
        icon: Icon(
          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          size: 18,
        ),
        style: IconButton.styleFrom(
          minimumSize: Size(size, size),
          maximumSize: Size(size, size),
          fixedSize: Size(size, size),
          padding: EdgeInsets.zero,
          backgroundColor: colors.chipBackground,
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.cardBorder, width: 1),
          shape: const CircleBorder(),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
