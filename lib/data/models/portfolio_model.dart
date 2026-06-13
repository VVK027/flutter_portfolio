import 'package:json_annotation/json_annotation.dart';

part 'portfolio_model.g.dart';

@JsonSerializable()
class PortfolioModel {
  final String name;
  final String title;
  final String location;
  final List<String> summary;
  final List<StrengthModel>? strengths;
  final List<ExperienceModel> experience;
  final List<ProjectModel> projects;
  final List<ReviewModel>? reviews;
  final List<String> awards;
  final List<String> achievements;
  final List<String> education;
  final List<String> certifications;
  final ContactModel contact;

  PortfolioModel(
    this.name,
    this.title,
    this.location,
    this.summary,
    this.strengths,
    this.experience,
    this.projects,
    this.reviews,
    this.awards,
    this.achievements,
    this.education,
    this.certifications,
    this.contact,
  );

  factory PortfolioModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioModelToJson(this);
}

@JsonSerializable()
class StrengthModel {
  final String title;
  final String description;

  StrengthModel(this.title, this.description);

  factory StrengthModel.fromJson(Map<String, dynamic> json) =>
      _$StrengthModelFromJson(json);

  Map<String, dynamic> toJson() => _$StrengthModelToJson(this);
}

@JsonSerializable()
class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> bullets;

  ExperienceModel(
    this.role,
    this.company,
    this.period,
    this.location,
    this.bullets,
  );

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceModelToJson(this);
}

@JsonSerializable()
class ProjectModel {
  final String name;
  final String desc;
  final List<String> tags;
  @JsonKey(fromJson: _urlListFromJson, toJson: _urlListToJson)
  final List<String> playStoreUrl;
  @JsonKey(fromJson: _urlListFromJson, toJson: _urlListToJson)
  final List<String> appStoreUrl;
  final String? previewImage;
  final List<String>? fullDescription;
  final List<String>? features;
  final String? githubUrl;
  final String? pubUrl;

  ProjectModel(
    this.name,
    this.desc,
    this.tags,
    this.playStoreUrl,
    this.appStoreUrl,
    this.previewImage,
    this.fullDescription,
    this.features,
    this.githubUrl,
    this.pubUrl,
  );

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}

List<String> _urlListFromJson(dynamic json) {
  if (json == null) return const [];
  if (json is String) {
    final trimmed = json.trim();
    return trimmed.isEmpty ? const [] : [trimmed];
  }
  if (json is List) {
    return json
        .map((e) => (e as String).trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
  return const [];
}

dynamic _urlListToJson(List<String> urls) {
  if (urls.isEmpty) return '';
  if (urls.length == 1) return urls.first;
  return urls;
}

@JsonSerializable()
class ReviewModel {
  final String quote;
  final String name;
  final String role;
  final String? company;
  final int rating;

  ReviewModel(
    this.quote,
    this.name,
    this.role,
    this.company,
    this.rating,
  );

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class ContactModel {
  final String note;
  final String? email;
  final String? phone;
  final String? location;
  final List<String>? links;

  ContactModel(this.note, this.email, this.phone, this.location, this.links);

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
