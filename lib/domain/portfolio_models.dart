import 'package:json_annotation/json_annotation.dart';

part 'portfolio_models.g.dart';

@JsonSerializable()
class Portfolio {
  final String name;
  final String title;
  final String location;
  final List<String> summary;
  final Skills? skills;
  final List<Experience> experience;
  final List<Project> projects;
  final List<String> awards;
  final List<String> education;
  final List<String> certifications;
  final Contact contact;

  Portfolio(
    this.name,
    this.title,
    this.location,
    this.summary,
    this.skills,
    this.experience,
    this.projects,
    this.awards,
    this.education,
    this.certifications,
    this.contact,
  );

  factory Portfolio.fromJson(Map<String, dynamic> json) =>
      _$PortfolioFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioToJson(this);
}

@JsonSerializable()
class Skills {
  final List<String> core;
  final List<String> additional;

  Skills(this.core, this.additional);

  factory Skills.fromJson(Map<String, dynamic> json) => _$SkillsFromJson(json);

  Map<String, dynamic> toJson() => _$SkillsToJson(this);
}

@JsonSerializable()
class Experience {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> bullets;

  Experience(this.role, this.company, this.period, this.location, this.bullets);

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

@JsonSerializable()
class Project {
  final String name;
  final String desc;
  final List<String> tags;

  Project(this.name, this.desc, this.tags);

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

@JsonSerializable()
class Contact {
  final String note;

  Contact(this.note);

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
