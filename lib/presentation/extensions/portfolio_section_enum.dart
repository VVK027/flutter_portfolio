enum PortfolioSectionEnum {
  about('About', 'About Me'),
  skills('Skills', 'Skills and Expertise'),
  experience('Experience', 'Experience'),
  projects('Projects', 'Projects'),
  openSource('OpenSource', 'Open Source'),
  reviews('Reviews', 'Reviews'),
  awards('Awards', 'Awards'),
  achievements('Achievements', 'Achievements'),
  education('Education', 'Education'),
  certifications('Certifications', 'Certifications'),
  contact('Contact', 'Contact Me');

  const PortfolioSectionEnum(this.id, this.title);
  final String id;
  final String title;

  static PortfolioSectionEnum? fromId(String? id) {
    if (id == null) return null;
    for (final section in PortfolioSectionEnum.values) {
      if (section.id == id) return section;
    }
    return null;
  }
}
