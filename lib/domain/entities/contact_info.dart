class PrimarySocialLinks {
  final String? linkedin;
  final String? github;
  final String? facebook;
  final String? whatsapp;

  const PrimarySocialLinks({
    this.linkedin,
    this.github,
    this.facebook,
    this.whatsapp,
  });
}

class ContactInfo {
  final String? email;
  final String? phone;
  final String location;
  final PrimarySocialLinks primaryLinks;

  const ContactInfo({
    required this.email,
    required this.phone,
    required this.location,
    required this.primaryLinks,
  });

  bool get hasEmail => (email ?? '').isNotEmpty;
  bool get hasPhone => (phone ?? '').isNotEmpty;
}
