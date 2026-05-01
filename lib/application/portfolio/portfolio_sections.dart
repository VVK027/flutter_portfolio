enum PortfolioSection {
  about('About', 'About Me'),
  skills('Skills', 'Skills and Expertise'),
  experience('Experience', 'Experience'),
  projects('Projects', 'Projects'),
  awards('Awards', 'Awards'),
  education('Education', 'Education'),
  certifications('Certifications', 'Certifications'),
  contact('Contact', 'Contact');

  const PortfolioSection(this.id, this.title);
  final String id;
  final String title;

  static PortfolioSection? fromId(String? id) {
    if (id == null) return null;
    for (final section in PortfolioSection.values) {
      if (section.id == id) return section;
    }
    return null;
  }
}
