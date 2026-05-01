import 'package:flutter/material.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';

class AboutSection extends StatelessWidget {
  final Portfolio portfolio;
  const AboutSection({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    final projectsCount = portfolio.projects.length;
    final experienceCount = portfolio.experience.length;
    final companiesCount = portfolio.experience
        .map((e) => e.company)
        .toSet()
        .length;
    final yearsExperience = _deriveYearsExperience(portfolio.experience);
    final androidAppsPublished = _deriveAndroidPublishedApps(portfolio.projects);
    final iosAppsPublished = _deriveIosPublishedApps(portfolio.projects);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._buildSummary(portfolio.summary),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _AboutStatTile(
              value: '$yearsExperience+',
              label: 'YEARS EXP.',
              accent: const Color(0xFFFF66C7),
            ),
            _AboutStatTile(
              value: '$companiesCount+',
              label: 'COMPANIES',
              accent: const Color(0xFF7EC8FF),
            ),
            _AboutStatTile(
              value: '$experienceCount+',
              label: 'ROLES',
              accent: const Color(0xFFB177FF),
            ),
            _AboutStatTile(
              value: '$projectsCount+',
              label: 'PROJECTS',
              accent: const Color(0xFF00D6FF),
            ),
            _AboutStatTile(
              value: '$androidAppsPublished+',
              label: 'ANDROID APPS',
              accent: const Color(0xFF00D6FF),
            ),
            _AboutStatTile(
              value: '$iosAppsPublished+',
              label: 'IOS APPS',
              accent: const Color(0xFF00D6FF),
            ),
          ],
        ),
      ],
    );
  }
}

List<Widget> _buildSummary(List<String>? summary) => (summary ?? [])
    .map(
      (s) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(s)),
    )
    .toList();

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

int _deriveAndroidPublishedApps(List<Project> projects) => projects
    .where(
      (project) =>
          (Uri.tryParse(
                (project.playStoreUrl ?? '').trim(),
              )?.host.toLowerCase() ??
              '')
              .contains('play.google.com'),
    )
    .length;

int _deriveIosPublishedApps(List<Project> projects) => projects
    .where(
      (project) =>
          (Uri.tryParse((project.appStoreUrl ?? '').trim())?.host.toLowerCase() ??
              '')
              .contains('apps.apple.com'),
    )
    .length;

class _AboutStatTile extends StatelessWidget {
  final String value;
  final String label;
  final Color accent;
  const _AboutStatTile({
    required this.value,
    required this.label,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 170),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF171A28), Color(0xFF111423)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF2A2F41)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 42,
              height: 1,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
