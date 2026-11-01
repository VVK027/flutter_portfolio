import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viivekportfolio/domain/entities/portfolio.dart';
import 'package:viivekportfolio/presentation/extensions/portfolio_section_enum.dart';
import 'package:viivekportfolio/presentation/portfolio/providers/portfolio_providers.dart';
import 'package:viivekportfolio/presentation/widgets/sections/about_section.dart';
import 'package:viivekportfolio/presentation/widgets/sections/contact_section.dart';
import 'package:viivekportfolio/presentation/widgets/sections/experience_section.dart';
import 'package:viivekportfolio/presentation/widgets/sections/open_source_section.dart';
import 'package:viivekportfolio/presentation/widgets/sections/projects_section.dart';
import 'package:viivekportfolio/presentation/widgets/sections/reviews_section.dart';
import 'package:viivekportfolio/presentation/widgets/sections/skills_section.dart';

export 'package:viivekportfolio/presentation/widgets/sections/section_shell.dart';

Widget buildSection(
  PortfolioSectionEnum section,
  Portfolio portfolio,
  WidgetRef ref,
) {
  // Use cases are read lazily inside each branch so building one section does
  // not resolve providers that section never uses.
  switch (section) {
    case PortfolioSectionEnum.about:
      return AboutSection(
        summary: portfolio.summary,
        metrics: ref.read(aboutMetricsUseCaseProvider).build(portfolio),
        strengths: portfolio.strengths ?? [],
      );
    case PortfolioSectionEnum.skills:
      return SkillsSection(
        categories: ref.read(skillCategoriesUseCaseProvider).build(),
      );
    case PortfolioSectionEnum.experience:
      return ExperienceSection(experience: portfolio.experience);
    case PortfolioSectionEnum.projects:
      return const ProjectsSection();
    case PortfolioSectionEnum.openSource:
      return const OpenSourceSection();
    case PortfolioSectionEnum.reviews:
      return ReviewsSection(reviews: portfolio.reviews ?? []);
    case PortfolioSectionEnum.awards:
      return SimpleBulletsSection(items: portfolio.awards);
    case PortfolioSectionEnum.achievements:
      return SimpleBulletsSection(items: portfolio.achievements);
    case PortfolioSectionEnum.education:
      return SimpleBulletsSection(items: portfolio.education);
    case PortfolioSectionEnum.certifications:
      return SimpleBulletsSection(items: portfolio.certifications);
    case PortfolioSectionEnum.contact:
      return ContactSection(
        viewData: ref.read(contactInfoUseCaseProvider).build(
              portfolio.contact,
              portfolio.location,
            ),
      );
  }
}
