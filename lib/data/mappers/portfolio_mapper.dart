import 'package:vivekdevfolio/data/models/portfolio_model.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class PortfolioMapper {
  const PortfolioMapper._();

  static Portfolio toEntity(PortfolioModel model) {
    return Portfolio(
      name: model.name,
      title: model.title,
      location: model.location,
      summary: model.summary,
      strengths: model.strengths?.map(_strengthToEntity).toList(),
      experience: model.experience.map(_experienceToEntity).toList(),
      projects: model.projects.map(_projectToEntity).toList(),
      reviews: model.reviews?.map(_reviewToEntity).toList(),
      awards: model.awards,
      education: model.education,
      certifications: model.certifications,
      contact: _contactToEntity(model.contact),
    );
  }

  static Strength _strengthToEntity(StrengthModel model) {
    return Strength(title: model.title, description: model.description);
  }

  static Experience _experienceToEntity(ExperienceModel model) {
    return Experience(
      role: model.role,
      company: model.company,
      period: model.period,
      location: model.location,
      bullets: model.bullets,
    );
  }

  static Project _projectToEntity(ProjectModel model) {
    return Project(
      name: model.name,
      desc: model.desc,
      tags: model.tags,
      playStoreUrl: model.playStoreUrl,
      appStoreUrl: model.appStoreUrl,
      previewImage: model.previewImage,
      fullDescription: model.fullDescription,
      features: model.features,
      githubUrl: model.githubUrl,
      pubUrl: model.pubUrl,
    );
  }

  static Review _reviewToEntity(ReviewModel model) {
    return Review(
      quote: model.quote,
      name: model.name,
      role: model.role,
      company: model.company,
      rating: model.rating,
    );
  }

  static Contact _contactToEntity(ContactModel model) {
    return Contact(
      note: model.note,
      email: model.email,
      phone: model.phone,
      location: model.location,
      links: model.links,
    );
  }
}
