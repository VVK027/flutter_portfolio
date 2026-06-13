import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Semantic colors required to build the shared [buildAppTheme] configuration.
///
/// Implement this in your project's `app_colors.dart` and pass the result to
/// [buildAppTheme] along with the matching [ThemeExtension].
abstract class AppThemeColors {
  Color get scaffold;
  Color get surface;
  Color get card;
  Color get sectionBorder;
  Color get textPrimary;
  Color get textSecondary;
  Color get textMuted;
  Color get chipBackground;
  Color get chipBorder;
  Color get chipLabel;
  Color get accent;
  Color get accentSecondary;
}

class Metrics extends ThemeExtension<Metrics> {
  final double sectionHPad;
  const Metrics({this.sectionHPad = 20});

  @override
  Metrics copyWith({double? sectionHPad}) =>
      Metrics(sectionHPad: sectionHPad ?? this.sectionHPad);

  @override
  Metrics lerp(ThemeExtension<Metrics>? other, double t) => Metrics(
        sectionHPad:
            lerpDouble(sectionHPad, (other as Metrics).sectionHPad, t)!,
      );
}

TextTheme _baseTextTheme(
  Brightness brightness,
  AppThemeColors colors, {
  required String fontFamily,
}) {
  final source = brightness == Brightness.dark
      ? ThemeData.dark().textTheme
      : ThemeData.light().textTheme;
  final themed = source.apply(fontFamily: fontFamily);
  return themed.copyWith(
    headlineMedium: themed.headlineMedium?.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.3,
      height: 1.12,
      color: colors.textPrimary,
    ),
    headlineSmall: themed.headlineSmall?.copyWith(
      fontSize: 27,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
      height: 1.15,
      color: colors.textPrimary,
    ),
    titleLarge: themed.titleLarge?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.15,
      height: 1.2,
      color: colors.textPrimary,
    ),
    titleMedium: themed.titleMedium?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.25,
      color: colors.textPrimary,
    ),
    bodyLarge: themed.bodyLarge?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.52,
      letterSpacing: 0.05,
      color: colors.textSecondary,
    ),
    bodyMedium: themed.bodyMedium?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0.05,
      color: colors.textSecondary,
    ),
    bodySmall: themed.bodySmall?.copyWith(
      fontSize: 13.5,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.15,
      color: colors.textMuted,
    ),
    labelLarge: themed.labelLarge?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.45,
      color: colors.textPrimary,
    ),
  );
}

/// Builds a Material 3 theme from project-specific color tokens.
ThemeData buildAppTheme<C extends ThemeExtension<C>>({
  required Brightness brightness,
  required AppThemeColors colors,
  required C colorExtension,
  String fontFamily = 'Poppins',
  Metrics metrics = const Metrics(sectionHPad: 20),
}) {
  final scheme = ColorScheme(
    brightness: brightness,
    primary: colors.accent,
    onPrimary: Colors.white,
    secondary: colors.accentSecondary,
    onSecondary: Colors.white,
    surface: colors.surface,
    onSurface: colors.textPrimary,
    error: const Color(0xFFEF4444),
    onError: Colors.white,
  );

  return ThemeData(
    brightness: brightness,
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: colors.scaffold,
    cardColor: colors.card,
    dividerColor: colors.sectionBorder,
    textTheme: _baseTextTheme(brightness, colors, fontFamily: fontFamily),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: colors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle:
          _baseTextTheme(brightness, colors, fontFamily: fontFamily).titleLarge,
      iconTheme: IconThemeData(color: colors.textPrimary),
    ),
    iconTheme: IconThemeData(color: colors.textPrimary),
    chipTheme: ChipThemeData(
      backgroundColor: colors.chipBackground,
      side: BorderSide(color: colors.chipBorder),
      labelStyle: TextStyle(color: colors.chipLabel, fontSize: 12.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: colors.card,
      textStyle: TextStyle(color: colors.textPrimary),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.accent),
    extensions: [colorExtension, metrics],
  );
}
