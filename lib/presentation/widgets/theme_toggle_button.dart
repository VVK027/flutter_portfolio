import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivekdevfolio/core/provider/app_theme_provider.dart';

/// Compact theme switch — moon for dark mode, sun for light mode.
class ThemeToggleButton extends ConsumerWidget {
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  const ThemeToggleButton({
    super.key,
    this.size = 34,
    this.backgroundColor = const Color(0xFFF1F5F9),
    this.foregroundColor = const Color(0xFF0F172A),
    this.borderColor = const Color(0xFFDCE3F0),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final isDark = mode == ThemeMode.dark;

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
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor, width: 1),
          shape: const CircleBorder(),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
