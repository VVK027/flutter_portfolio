import 'package:freezed_annotation/freezed_annotation.dart';
part 'portfolio_models.freezed.dart';
part 'portfolio_models.g.dart';

@freezed
class Portfolio with _$Portfolio {
  const factory Portfolio({
    required String name,
    required String title,
    required String location,
    required List<String> summary,
    required Skills skills,
    required List<Experience> experience,
    required List<Project> projects,
    required List<String> awards,
    required List<String> education,
    required List<String> certifications,
    required Contact contact,
  }) = _Portfolio;

  factory Portfolio.fromJson(Map<String, dynamic> json) => _$PortfolioFromJson(json);
}

@freezed
class Skills with _$Skills {
  const factory Skills({
    required List<String> core,
    required List<String> additional,
  }) = _Skills;
  factory Skills.fromJson(Map<String, dynamic> json) => _$SkillsFromJson(json);
}

@freezed
class Experience with _$Experience {
  const factory Experience({
    required String role,
    required String company,
    required String period,
    required String location,
    required List<String> bullets,
  }) = _Experience;
  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);
}

@freezed
class Project with _$Project {
  const factory Project({
    required String name,
    required String desc,
    required List<String> tags,
  }) = _Project;
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}

@freezed
class Contact with _$Contact {
  const factory Contact({
    required String note,
  }) = _Contact;
  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
}
