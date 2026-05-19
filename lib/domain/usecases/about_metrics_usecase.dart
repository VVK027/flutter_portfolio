import 'package:vivekdevfolio/domain/entities/about_metrics.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class AboutMetricsUseCase {
  const AboutMetricsUseCase();

  AboutMetrics build(Portfolio portfolio) {
    final projectsCount = portfolio.projects.length;
    final experienceCount = portfolio.experience.length;
    final companiesCount = portfolio.experience
        .map((experience) => experience.company)
        .toSet()
        .length;
    final yearsExperience = _deriveYearsExperience(portfolio.experience);
    final androidAppsPublished = _derivePublishedApps(
      portfolio.projects,
      hostPart: 'play.google.com',
    );
    final iosAppsPublished = _derivePublishedApps(
      portfolio.projects,
      hostPart: 'apps.apple.com',
    );

    return AboutMetrics(
      tiles: [
        AboutStatTileData(
          value: yearsExperience,
          label: 'YEARS EXP.',
          accentKey: 'magenta',
        ),
        AboutStatTileData(
          value: companiesCount,
          label: 'COMPANIES',
          accentKey: 'blueLight',
        ),
        AboutStatTileData(
          value: experienceCount,
          label: 'ROLES',
          accentKey: 'violet',
        ),
        AboutStatTileData(
          value: projectsCount,
          label: 'PROJECTS',
          accentKey: 'cyan',
        ),
        AboutStatTileData(
          value: androidAppsPublished,
          label: 'ANDROID APPS',
          accentKey: 'cyan',
        ),
        AboutStatTileData(
          value: iosAppsPublished,
          label: 'IOS APPS',
          accentKey: 'cyan',
        ),
      ],
    );
  }

  int _deriveYearsExperience(List<Experience> experience) {
    if (experience.isEmpty) return 0;
    final yearExp = RegExp(r'(\d{4})');
    int? minYear;
    for (final item in experience) {
      final years = yearExp
          .allMatches(item.period)
          .map((m) => int.tryParse(m.group(1) ?? ''))
          .whereType<int>()
          .toList();
      if (years.isEmpty) continue;
      final startYear = years.first;
      minYear = minYear == null
          ? startYear
          : (startYear < minYear ? startYear : minYear);
    }
    if (minYear == null) return 0;
    final currentYear = DateTime.now().year;
    final diff = currentYear - minYear;
    return diff > 0 ? diff : 1;
  }

  int _derivePublishedApps(List<Project> projects, {required String hostPart}) {
    return projects
        .where((project) {
          final matchesPlay = project.playStoreUrl.any((url) {
            final host = Uri.tryParse(url)?.host.toLowerCase() ?? '';
            return host.contains(hostPart);
          });
          final matchesApp = project.appStoreUrl.any((url) {
            final host = Uri.tryParse(url)?.host.toLowerCase() ?? '';
            return host.contains(hostPart);
          });
          return matchesPlay || matchesApp;
        })
        .length;
  }
}
