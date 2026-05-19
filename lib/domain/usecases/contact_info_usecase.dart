import 'package:vivekdevfolio/domain/entities/contact_info.dart';
import 'package:vivekdevfolio/domain/entities/portfolio.dart';

class ContactInfoUseCase {
  const ContactInfoUseCase();

  ContactInfo build(Contact contact, String fallbackLocation) {
    final links = contact.links ?? const <String>[];
    final location = (contact.location ?? '').isNotEmpty
        ? contact.location!
        : fallbackLocation;
    return ContactInfo(
      email: contact.email,
      phone: contact.phone,
      location: location,
      primaryLinks: _primarySocialLinks(links),
    );
  }

  PrimarySocialLinks _primarySocialLinks(List<String> links) {
    String? byHost(String hostPart) {
      for (final link in links) {
        final host = (Uri.tryParse(link)?.host ?? '').toLowerCase();
        if (host.contains(hostPart)) return link;
      }
      return null;
    }

    return PrimarySocialLinks(
      linkedin: byHost('linkedin'),
      github: byHost('github'),
      facebook: byHost('facebook'),
      whatsapp: byHost('wa.me'),
    );
  }
}
