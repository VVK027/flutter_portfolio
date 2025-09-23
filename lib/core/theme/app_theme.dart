
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class Metrics extends ThemeExtension<Metrics> {
  final double sectionHPad;
  const Metrics({this.sectionHPad = 20});
  @override
  Metrics copyWith({double? sectionHPad}) => Metrics(sectionHPad: sectionHPad ?? this.sectionHPad);
  @override
  Metrics lerp(ThemeExtension<Metrics>? other, double t) =>
      Metrics(sectionHPad: lerpDouble(sectionHPad, (other as Metrics).sectionHPad, t)!);
}

ThemeData buildTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4F8CFF),
      surface: Color(0xFF151821),
    ),
    scaffoldBackgroundColor: const Color(0xFF0E0F12),
    fontFamily: 'Roboto',
    useMaterial3: true,
    extensions: const [Metrics(sectionHPad: 20)],
  );
}
