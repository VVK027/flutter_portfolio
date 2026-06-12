import 'package:flutter/material.dart';

/// Semantic portfolio colors — use via [Theme.of(context).extension<AppColors>()].
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color scaffold;
  final Color surface;
  final Color card;
  final Color cardBorder;
  final Color sectionBorder;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color appBarGradientStart;
  final Color appBarGradientEnd;
  final Color appBarBorder;
  final Color shadow;
  final Color navActive;
  final Color navInactive;
  final Color profileBorder;
  final Color previewBackground;
  final Color previewBorder;
  final Color previewGradientStart;
  final Color previewGradientEnd;
  final Color previewAccent;
  final Color previewIcon;
  final Color carouselNavBg;
  final Color carouselNavBorder;
  final Color carouselNavBorderActive;
  final Color carouselIndicatorActive;
  final Color carouselIndicatorInactive;
  final Color carouselIcon;
  final Color carouselIconDisabled;
  final Color chipBackground;
  final Color chipBorder;
  final Color chipLabel;
  final Color filterChipSelected;
  final Color filterChipUnselected;
  final Color accent;
  final Color accentSecondary;
  final Color accentGradientStart;
  final Color accentGradientEnd;
  final Color starFilled;
  final Color starEmpty;
  final Color avatarBackground;
  final Color quoteIcon;
  final Color playStoreFg;
  final Color playStoreBorder;
  final Color appStoreFg;
  final Color appStoreBorder;
  final Color githubFg;
  final Color githubBorder;
  final Color pubFg;
  final Color pubBorder;
  final Color internalLabel;
  final Color success;
  final Color toggleCircle;
  final Color toggleIcon;
  final Color contactGradientStart;
  final Color contactGradientEnd;
  final Color statGradientStart;
  final Color statGradientEnd;

  const AppColors({
    required this.scaffold,
    required this.surface,
    required this.card,
    required this.cardBorder,
    required this.sectionBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.appBarGradientStart,
    required this.appBarGradientEnd,
    required this.appBarBorder,
    required this.shadow,
    required this.navActive,
    required this.navInactive,
    required this.profileBorder,
    required this.previewBackground,
    required this.previewBorder,
    required this.previewGradientStart,
    required this.previewGradientEnd,
    required this.previewAccent,
    required this.previewIcon,
    required this.carouselNavBg,
    required this.carouselNavBorder,
    required this.carouselNavBorderActive,
    required this.carouselIndicatorActive,
    required this.carouselIndicatorInactive,
    required this.carouselIcon,
    required this.carouselIconDisabled,
    required this.chipBackground,
    required this.chipBorder,
    required this.chipLabel,
    required this.filterChipSelected,
    required this.filterChipUnselected,
    required this.accent,
    required this.accentSecondary,
    required this.accentGradientStart,
    required this.accentGradientEnd,
    required this.starFilled,
    required this.starEmpty,
    required this.avatarBackground,
    required this.quoteIcon,
    required this.playStoreFg,
    required this.playStoreBorder,
    required this.appStoreFg,
    required this.appStoreBorder,
    required this.githubFg,
    required this.githubBorder,
    required this.pubFg,
    required this.pubBorder,
    required this.internalLabel,
    required this.success,
    required this.toggleCircle,
    required this.toggleIcon,
    required this.contactGradientStart,
    required this.contactGradientEnd,
    required this.statGradientStart,
    required this.statGradientEnd,
  });

  static const light = AppColors(
    scaffold: Color(0xFFF3F5FA),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFFFFFF),
    cardBorder: Color(0xFFDCE3F0),
    sectionBorder: Color(0xFFE4E9F2),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF334155),
    textMuted: Color(0xFF64748B),
    appBarGradientStart: Color(0xE6FFFFFF),
    appBarGradientEnd: Color(0xE6F8FAFF),
    appBarBorder: Color(0xFFD8E0EE),
    shadow: Color(0x14000000),
    navActive: Color(0xFF0F172A),
    navInactive: Color(0xFF64748B),
    profileBorder: Color(0xFFCBD5E1),
    previewBackground: Color(0xFFEEF2F8),
    previewBorder: Color(0xFFD5DEEA),
    previewGradientStart: Color(0xFFE8EDF5),
    previewGradientEnd: Color(0xFFDCE4F0),
    previewAccent: Color(0xFF4F5D9A),
    previewIcon: Color(0xFF94A3B8),
    carouselNavBg: Color(0xFFFFFFFF),
    carouselNavBorder: Color(0xFFCBD5E1),
    carouselNavBorderActive: Color(0xFF6366F1),
    carouselIndicatorActive: Color(0xFF6366F1),
    carouselIndicatorInactive: Color(0xFFCBD5E1),
    carouselIcon: Color(0xFF334155),
    carouselIconDisabled: Color(0xFF94A3B8),
    chipBackground: Color(0xFFF1F5F9),
    chipBorder: Color(0xFFCBD5E1),
    chipLabel: Color(0xFF334155),
    filterChipSelected: Color(0xFF4F46E5),
    filterChipUnselected: Color(0xFFF1F5F9),
    accent: Color(0xFF4F46E5),
    accentSecondary: Color(0xFF7C3AED),
    accentGradientStart: Color(0xFF6366F1),
    accentGradientEnd: Color(0xFFDB2777),
    starFilled: Color(0xFFF59E0B),
    starEmpty: Color(0xFFCBD5E1),
    avatarBackground: Color(0xFF6366F1),
    quoteIcon: Color(0xFF6366F1),
    playStoreFg: Color(0xFF0369A1),
    playStoreBorder: Color(0xFF7DD3FC),
    appStoreFg: Color(0xFF3730A3),
    appStoreBorder: Color(0xFFC7D2FE),
    githubFg: Color(0xFF1E293B),
    githubBorder: Color(0xFFCBD5E1),
    pubFg: Color(0xFF0175C2),
    pubBorder: Color(0xFF7EC8E8),
    internalLabel: Color(0xFF64748B),
    success: Color(0xFF16A34A),
    toggleCircle: Color(0xFFFFFFFF),
    toggleIcon: Color(0xFF0F172A),
    contactGradientStart: Color(0xFFFFFFFF),
    contactGradientEnd: Color(0xFFF1F5F9),
    statGradientStart: Color(0xFFF8FAFC),
    statGradientEnd: Color(0xFFEEF2FF),
  );

  static const dark = AppColors(
    scaffold: Color(0xFF0F121A),
    surface: Color(0xFF151821),
    card: Color(0xFF161B29),
    cardBorder: Color(0xFF323A52),
    sectionBorder: Color(0xFF20232D),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFE2E8F0),
    textMuted: Color(0xFF94A3B8),
    appBarGradientStart: Color(0xDB161B2A),
    appBarGradientEnd: Color(0xC7111520),
    appBarBorder: Color(0xFF2C3347),
    shadow: Color(0x22000000),
    navActive: Color(0xFFFFFFFF),
    navInactive: Color(0xB3FFFFFF),
    profileBorder: Color(0xFF3A4155),
    previewBackground: Color(0xFF121824),
    previewBorder: Color(0xFF2A3148),
    previewGradientStart: Color(0xFF1E2640),
    previewGradientEnd: Color(0xFF2A3358),
    previewAccent: Color(0xFF5C6BC0),
    previewIcon: Color(0xFF4A5580),
    carouselNavBg: Color(0xFF12151F),
    carouselNavBorder: Color(0xFF343B52),
    carouselNavBorderActive: Color(0xA66B5CE7),
    carouselIndicatorActive: Color(0xFFB8A8F0),
    carouselIndicatorInactive: Color(0xFF3A3358),
    carouselIcon: Color(0xFFFFFFFF),
    carouselIconDisabled: Color(0x61FFFFFF),
    chipBackground: Color(0xFF21273A),
    chipBorder: Color(0xFF3A425B),
    chipLabel: Color(0xFFE9EDF8),
    filterChipSelected: Color(0xFF4F8CFF),
    filterChipUnselected: Color(0xFF21273A),
    accent: Color(0xFF6B5CE7),
    accentSecondary: Color(0xFF9B7BFF),
    accentGradientStart: Color(0xFF9B7BFF),
    accentGradientEnd: Color(0xFFE879F9),
    starFilled: Color(0xFFF5A623),
    starEmpty: Color(0xFF4A4F63),
    avatarBackground: Color(0xFF5B4FCF),
    quoteIcon: Color(0x596B5CE7),
    playStoreFg: Color(0xFFB8E1FF),
    playStoreBorder: Color(0xFF476186),
    appStoreFg: Color(0xFFD5DBFF),
    appStoreBorder: Color(0xFF4E5370),
    githubFg: Color(0xFFE0E0E0),
    githubBorder: Color(0xFF4E5370),
    pubFg: Color(0xFF64B5F6),
    pubBorder: Color(0xFF4E5370),
    internalLabel: Color(0xFF94A3B8),
    success: Color(0xFF81C784),
    toggleCircle: Color(0xFFE8EEFF),
    toggleIcon: Color(0xFF0F172A),
    contactGradientStart: Color(0xFF171C31),
    contactGradientEnd: Color(0xFF10152A),
    statGradientStart: Color(0xFF171A28),
    statGradientEnd: Color(0xFF111423),
  );

  @override
  AppColors copyWith({
    Color? scaffold,
    Color? surface,
    Color? card,
    Color? cardBorder,
    Color? sectionBorder,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? appBarGradientStart,
    Color? appBarGradientEnd,
    Color? appBarBorder,
    Color? shadow,
    Color? navActive,
    Color? navInactive,
    Color? profileBorder,
    Color? previewBackground,
    Color? previewBorder,
    Color? previewGradientStart,
    Color? previewGradientEnd,
    Color? previewAccent,
    Color? previewIcon,
    Color? carouselNavBg,
    Color? carouselNavBorder,
    Color? carouselNavBorderActive,
    Color? carouselIndicatorActive,
    Color? carouselIndicatorInactive,
    Color? carouselIcon,
    Color? carouselIconDisabled,
    Color? chipBackground,
    Color? chipBorder,
    Color? chipLabel,
    Color? filterChipSelected,
    Color? filterChipUnselected,
    Color? accent,
    Color? accentSecondary,
    Color? accentGradientStart,
    Color? accentGradientEnd,
    Color? starFilled,
    Color? starEmpty,
    Color? avatarBackground,
    Color? quoteIcon,
    Color? playStoreFg,
    Color? playStoreBorder,
    Color? appStoreFg,
    Color? appStoreBorder,
    Color? githubFg,
    Color? githubBorder,
    Color? pubFg,
    Color? pubBorder,
    Color? internalLabel,
    Color? success,
    Color? toggleCircle,
    Color? toggleIcon,
    Color? contactGradientStart,
    Color? contactGradientEnd,
    Color? statGradientStart,
    Color? statGradientEnd,
  }) {
    return AppColors(
      scaffold: scaffold ?? this.scaffold,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      cardBorder: cardBorder ?? this.cardBorder,
      sectionBorder: sectionBorder ?? this.sectionBorder,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      appBarGradientStart: appBarGradientStart ?? this.appBarGradientStart,
      appBarGradientEnd: appBarGradientEnd ?? this.appBarGradientEnd,
      appBarBorder: appBarBorder ?? this.appBarBorder,
      shadow: shadow ?? this.shadow,
      navActive: navActive ?? this.navActive,
      navInactive: navInactive ?? this.navInactive,
      profileBorder: profileBorder ?? this.profileBorder,
      previewBackground: previewBackground ?? this.previewBackground,
      previewBorder: previewBorder ?? this.previewBorder,
      previewGradientStart: previewGradientStart ?? this.previewGradientStart,
      previewGradientEnd: previewGradientEnd ?? this.previewGradientEnd,
      previewAccent: previewAccent ?? this.previewAccent,
      previewIcon: previewIcon ?? this.previewIcon,
      carouselNavBg: carouselNavBg ?? this.carouselNavBg,
      carouselNavBorder: carouselNavBorder ?? this.carouselNavBorder,
      carouselNavBorderActive:
          carouselNavBorderActive ?? this.carouselNavBorderActive,
      carouselIndicatorActive:
          carouselIndicatorActive ?? this.carouselIndicatorActive,
      carouselIndicatorInactive:
          carouselIndicatorInactive ?? this.carouselIndicatorInactive,
      carouselIcon: carouselIcon ?? this.carouselIcon,
      carouselIconDisabled: carouselIconDisabled ?? this.carouselIconDisabled,
      chipBackground: chipBackground ?? this.chipBackground,
      chipBorder: chipBorder ?? this.chipBorder,
      chipLabel: chipLabel ?? this.chipLabel,
      filterChipSelected: filterChipSelected ?? this.filterChipSelected,
      filterChipUnselected: filterChipUnselected ?? this.filterChipUnselected,
      accent: accent ?? this.accent,
      accentSecondary: accentSecondary ?? this.accentSecondary,
      accentGradientStart: accentGradientStart ?? this.accentGradientStart,
      accentGradientEnd: accentGradientEnd ?? this.accentGradientEnd,
      starFilled: starFilled ?? this.starFilled,
      starEmpty: starEmpty ?? this.starEmpty,
      avatarBackground: avatarBackground ?? this.avatarBackground,
      quoteIcon: quoteIcon ?? this.quoteIcon,
      playStoreFg: playStoreFg ?? this.playStoreFg,
      playStoreBorder: playStoreBorder ?? this.playStoreBorder,
      appStoreFg: appStoreFg ?? this.appStoreFg,
      appStoreBorder: appStoreBorder ?? this.appStoreBorder,
      githubFg: githubFg ?? this.githubFg,
      githubBorder: githubBorder ?? this.githubBorder,
      pubFg: pubFg ?? this.pubFg,
      pubBorder: pubBorder ?? this.pubBorder,
      internalLabel: internalLabel ?? this.internalLabel,
      success: success ?? this.success,
      toggleCircle: toggleCircle ?? this.toggleCircle,
      toggleIcon: toggleIcon ?? this.toggleIcon,
      contactGradientStart:
          contactGradientStart ?? this.contactGradientStart,
      contactGradientEnd: contactGradientEnd ?? this.contactGradientEnd,
      statGradientStart: statGradientStart ?? this.statGradientStart,
      statGradientEnd: statGradientEnd ?? this.statGradientEnd,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      scaffold: l(scaffold, other.scaffold),
      surface: l(surface, other.surface),
      card: l(card, other.card),
      cardBorder: l(cardBorder, other.cardBorder),
      sectionBorder: l(sectionBorder, other.sectionBorder),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textMuted: l(textMuted, other.textMuted),
      appBarGradientStart: l(appBarGradientStart, other.appBarGradientStart),
      appBarGradientEnd: l(appBarGradientEnd, other.appBarGradientEnd),
      appBarBorder: l(appBarBorder, other.appBarBorder),
      shadow: l(shadow, other.shadow),
      navActive: l(navActive, other.navActive),
      navInactive: l(navInactive, other.navInactive),
      profileBorder: l(profileBorder, other.profileBorder),
      previewBackground: l(previewBackground, other.previewBackground),
      previewBorder: l(previewBorder, other.previewBorder),
      previewGradientStart: l(previewGradientStart, other.previewGradientStart),
      previewGradientEnd: l(previewGradientEnd, other.previewGradientEnd),
      previewAccent: l(previewAccent, other.previewAccent),
      previewIcon: l(previewIcon, other.previewIcon),
      carouselNavBg: l(carouselNavBg, other.carouselNavBg),
      carouselNavBorder: l(carouselNavBorder, other.carouselNavBorder),
      carouselNavBorderActive:
          l(carouselNavBorderActive, other.carouselNavBorderActive),
      carouselIndicatorActive:
          l(carouselIndicatorActive, other.carouselIndicatorActive),
      carouselIndicatorInactive:
          l(carouselIndicatorInactive, other.carouselIndicatorInactive),
      carouselIcon: l(carouselIcon, other.carouselIcon),
      carouselIconDisabled: l(carouselIconDisabled, other.carouselIconDisabled),
      chipBackground: l(chipBackground, other.chipBackground),
      chipBorder: l(chipBorder, other.chipBorder),
      chipLabel: l(chipLabel, other.chipLabel),
      filterChipSelected: l(filterChipSelected, other.filterChipSelected),
      filterChipUnselected: l(filterChipUnselected, other.filterChipUnselected),
      accent: l(accent, other.accent),
      accentSecondary: l(accentSecondary, other.accentSecondary),
      accentGradientStart: l(accentGradientStart, other.accentGradientStart),
      accentGradientEnd: l(accentGradientEnd, other.accentGradientEnd),
      starFilled: l(starFilled, other.starFilled),
      starEmpty: l(starEmpty, other.starEmpty),
      avatarBackground: l(avatarBackground, other.avatarBackground),
      quoteIcon: l(quoteIcon, other.quoteIcon),
      playStoreFg: l(playStoreFg, other.playStoreFg),
      playStoreBorder: l(playStoreBorder, other.playStoreBorder),
      appStoreFg: l(appStoreFg, other.appStoreFg),
      appStoreBorder: l(appStoreBorder, other.appStoreBorder),
      githubFg: l(githubFg, other.githubFg),
      githubBorder: l(githubBorder, other.githubBorder),
      pubFg: l(pubFg, other.pubFg),
      pubBorder: l(pubBorder, other.pubBorder),
      internalLabel: l(internalLabel, other.internalLabel),
      success: l(success, other.success),
      toggleCircle: l(toggleCircle, other.toggleCircle),
      toggleIcon: l(toggleIcon, other.toggleIcon),
      contactGradientStart:
          l(contactGradientStart, other.contactGradientStart),
      contactGradientEnd: l(contactGradientEnd, other.contactGradientEnd),
      statGradientStart: l(statGradientStart, other.statGradientStart),
      statGradientEnd: l(statGradientEnd, other.statGradientEnd),
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get appColors =>
      Theme.of(this).extension<AppColors>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? AppColors.dark
          : AppColors.light);
}
