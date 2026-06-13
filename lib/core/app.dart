import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivekdevfolio/core/provider/app_theme_provider.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';

import 'routing/app_router.dart';

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'vivek-devfolio',
      // Avoid using accent purple for the browser/PWA chrome on web.
      color: themeMode == ThemeMode.light
          ? AppColors.light.scaffold
          : AppColors.dark.scaffold,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final brightness = Theme.of(context).brightness;
        final colors =
        brightness == Brightness.dark ? AppColors.dark : AppColors.light;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: colors.scaffold,
            statusBarIconBrightness: brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
          ),
        );
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
