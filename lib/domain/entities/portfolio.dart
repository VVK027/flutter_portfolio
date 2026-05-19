class Portfolio {
  final String name;
  final String title;
  final String location;
  final List<String> summary;
  final List<Strength>? strengths;
  final List<Experience> experience;
  final List<Project> projects;
  final List<Review>? reviews;
  final List<String> awards;
  final List<String> education;
  final List<String> certifications;
  final Contact contact;

  const Portfolio({
    required this.name,
    required this.title,
    required this.location,
    required this.summary,
    required this.strengths,
    required this.experience,
    required this.projects,
    required this.reviews,
    required this.awards,
    required this.education,
    required this.certifications,
    required this.contact,
  });
}

class Strength {
  final String title;
  final String description;

  const Strength({required this.title, required this.description});
}

class Experience {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> bullets;

  const Experience({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.bullets,
  });
}

class Project {
  final String name;
  final String desc;
  final List<String> tags;
  final List<String> playStoreUrl;
  final List<String> appStoreUrl;
  final String? previewImage;
  final List<String>? fullDescription;
  final List<String>? features;
  final String? githubUrl;

  const Project({
    required this.name,
    required this.desc,
    required this.tags,
    required this.playStoreUrl,
    required this.appStoreUrl,
    this.previewImage,
    this.fullDescription,
    this.features,
    this.githubUrl,
  });
}

class Review {
  final String quote;
  final String name;
  final String role;
  final String? company;
  final int rating;

  const Review({
    required this.quote,
    required this.name,
    required this.role,
    this.company,
    required this.rating,
  });
}

class Contact {
  final String note;
  final String? email;
  final String? phone;
  final String? location;
  final List<String>? links;

  const Contact({
    required this.note,
    this.email,
    this.phone,
    this.location,
    this.links,
  });
}
