import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';
import 'package:vivekdevfolio/presentation/extensions/portfolio_section_enum.dart';
import 'package:vivekdevfolio/presentation/portfolio/providers/portfolio_providers.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/about_section.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/contact_section.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/experience_section.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/projects_section.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/reviews_section.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/skills_section.dart';

export 'package:vivekdevfolio/presentation/widgets/sections/section_shell.dart';

Widget buildSection(
  PortfolioSectionEnum section,
  Portfolio portfolio,
  WidgetRef ref,
) {
  final aboutMetricsUseCase = ref.read(aboutMetricsUseCaseProvider);
  final skillCategoriesUseCase = ref.read(skillCategoriesUseCaseProvider);
  final contactInfoUseCase = ref.read(contactInfoUseCaseProvider);
  switch (section) {
    case PortfolioSectionEnum.about:
      return AboutSection(
          summary: portfolio.summary,
          metrics: aboutMetricsUseCase.build(portfolio),
          strengths: portfolio.strengths ?? []
      );
    // case PortfolioSection.strengths:
    //   return StrengthsSection(strengths: portfolio.strengths ?? []);
    case PortfolioSectionEnum.skills:
      return SkillsSection(
        categories: skillCategoriesUseCase.build(),
      );
    case PortfolioSectionEnum.experience:
      return ExperienceSection(experience: portfolio.experience);
    case PortfolioSectionEnum.projects:
      return const ProjectsSection();
    case PortfolioSectionEnum.reviews:
      return ReviewsSection(reviews: portfolio.reviews ?? []);
    case PortfolioSectionEnum.awards:
      return SimpleBulletsSection(items: portfolio.awards);
    case PortfolioSectionEnum.education:
      return SimpleBulletsSection(items: portfolio.education);
    case PortfolioSectionEnum.certifications:
      return SimpleBulletsSection(items: portfolio.certifications);
    case PortfolioSectionEnum.contact:
      return ContactSection(
        viewData: contactInfoUseCase.build(
          portfolio.contact,
          portfolio.location,
        ),
      );
  }
}
