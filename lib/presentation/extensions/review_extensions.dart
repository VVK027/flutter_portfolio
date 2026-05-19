import 'package:vivekdevfolio/domain/entities/portfolio.dart';

extension ReviewPresentation on Review {
  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      return parts.first.length >= 2
          ? parts.first.substring(0, 2).toUpperCase()
          : parts.first.toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  String get subtitle {
    final companyText = (company ?? '').trim();
    if (companyText.isEmpty) return role;
    return '$role · $companyText';
  }
}
