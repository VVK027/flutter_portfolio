import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vivek_portfolio/application/portfolio/portfolio_sections.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';
import 'package:vivek_portfolio/presentation/widgets/sections/about_section.dart';
import 'package:vivek_portfolio/presentation/widgets/sections/contact_section.dart';
import 'package:vivek_portfolio/presentation/widgets/sections/experience_section.dart';
import 'package:vivek_portfolio/presentation/widgets/sections/projects_section.dart';
import 'package:vivek_portfolio/presentation/widgets/sections/skills_section.dart';

export 'package:vivek_portfolio/presentation/widgets/sections/section_shell.dart';

Widget buildSection(
  PortfolioSection section,
  Portfolio portfolio,
  WidgetRef _,
) {
  switch (section) {
    case PortfolioSection.about:
      return AboutSection(portfolio: portfolio);
    case PortfolioSection.skills:
      return SkillsSection(skills: portfolio.skills);
    case PortfolioSection.experience:
      return ExperienceSection(experience: portfolio.experience);
    case PortfolioSection.projects:
      return const ProjectsSection();
    case PortfolioSection.awards:
      return SimpleBulletsSection(items: portfolio.awards);
    case PortfolioSection.education:
      return SimpleBulletsSection(items: portfolio.education);
    case PortfolioSection.certifications:
      return SimpleBulletsSection(items: portfolio.certifications);
    case PortfolioSection.contact:
      return ContactSection(
        contact: portfolio.contact,
        fallbackLocation: portfolio.location,
      );
  }
}
