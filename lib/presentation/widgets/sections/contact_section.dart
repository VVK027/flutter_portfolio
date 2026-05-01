import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vivek_portfolio/domain/portfolio_models.dart';

class ContactSection extends StatelessWidget {
  final Contact contact;
  final String fallbackLocation;
  const ContactSection({
    super.key,
    required this.contact,
    required this.fallbackLocation,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final compact = c.maxWidth < 800;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: compact ? double.infinity : (c.maxWidth / 2) - 8,
                  child: _ContactInfoCard(
                    contact: contact,
                    fallbackLocation: fallbackLocation,
                  ),
                ),
                SizedBox(
                  width: compact ? double.infinity : (c.maxWidth / 2) - 8,
                  child: Column(
                    children: [
                      _OpportunityCard(
                        icon: Icons.badge_outlined,
                        title: 'Full-Time Position',
                        message:
                            'Looking for a dedicated Flutter developer to join your team? I am open to full-time opportunities.',
                        bullets: const [
                          'Immediate availability',
                          'Remote or On-site',
                        ],
                        cta: 'Discuss Opportunity',
                        onTap: () => _openOpportunityEmail(
                          context,
                          contact.email,
                          subject: 'Full-Time Flutter Opportunity',
                          body:
                              'Hi Vivek,\n\nI would like to discuss a full-time Flutter role with you.\n\nThanks.',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _OpportunityCard(
                        icon: Icons.description_outlined,
                        title: 'Freelance Project',
                        message:
                            'Have a mobile app project? Let us discuss how I can help bring your idea to life.',
                        bullets: const [
                          'Flexible engagement',
                          'Quality delivery',
                        ],
                        cta: 'Start a Conversation',
                        onTap: () => _openOpportunityEmail(
                          context,
                          contact.email,
                          subject: 'Freelance Mobile Project Discussion',
                          body:
                              'Hi Vivek,\n\nI would like to discuss a freelance mobile project with you.\n\nThanks.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Center(
              child: Text(
                '© ${DateTime.now().year} Vivek Kumar. All rights reserved.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF8E9CC5),
                  fontSize: 12,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  final Contact contact;
  final String fallbackLocation;
  const _ContactInfoCard({
    required this.contact,
    required this.fallbackLocation,
  });

  @override
  Widget build(BuildContext context) {
    final links = contact.links ?? const <String>[];
    final primaryLinks = _primarySocialLinks(links);
    final location = (contact.location ?? '').isNotEmpty
        ? contact.location!
        : fallbackLocation;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF171C31), Color(0xFF10152A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF2C3657)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          if ((contact.email ?? '').isNotEmpty)
            _ContactRow(
              icon: Icons.email_outlined,
              label: 'EMAIL',
              value: contact.email!,
              tint: const Color(0xFF2F79FF),
              onTap: () => _openEmail(context, contact.email!),
            ),
          if ((contact.phone ?? '').isNotEmpty) ...[
            const SizedBox(height: 10),
            _ContactRow(
              icon: Icons.call_outlined,
              label: 'PHONE',
              value: contact.phone!,
              tint: const Color(0xFFB746FF),
              onTap: () => _openPhone(context, contact.phone!),
            ),
          ],
          const SizedBox(height: 10),
          _ContactRow(
            icon: Icons.location_on_outlined,
            label: 'LOCATION',
            value: location,
            tint: const Color(0xFF8D6BFF),
            onTap: null,
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFF2A3354)),
          const SizedBox(height: 12),
          const Text(
            'CONNECT ON SOCIAL',
            style: TextStyle(
              color: Color(0xFF92A0C6),
              letterSpacing: 1.1,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              _SocialIconButton(
                onPressed: primaryLinks.linkedin == null
                    ? null
                    : () => _openUrl(context, primaryLinks.linkedin!),
                iconData: FontAwesomeIcons.linkedinIn,
                tooltip: 'LinkedIn',
              ),
              _SocialIconButton(
                onPressed: primaryLinks.github == null
                    ? null
                    : () => _openUrl(context, primaryLinks.github!),
                iconData: FontAwesomeIcons.github,
                tooltip: 'GitHub',
              ),
              _SocialIconButton(
                onPressed: primaryLinks.facebook == null
                    ? null
                    : () => _openUrl(context, primaryLinks.facebook!),
                iconData: FontAwesomeIcons.facebookF,
                tooltip: 'Facebook',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color tint;
  final VoidCallback? onTap;
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.tint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: tint.withValues(alpha: 0.18),
            child: Icon(icon, size: 18, color: tint),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF8E9CC5),
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OpportunityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final List<String> bullets;
  final String cta;
  final VoidCallback onTap;
  const _OpportunityCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.bullets,
    required this.cta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF28153B), Color(0xFF151B30)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFF323C64)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF31285D),
                child: Icon(icon, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),
          ...bullets.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Text('• ', style: TextStyle(color: Color(0xFF9B72FF))),
                  Expanded(
                    child: Text(
                      e,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF6A7398)),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(cta),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;
  final String tooltip;
  const _SocialIconButton({
    required this.onPressed,
    required this.iconData,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onPressed,
        child: Ink(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: isEnabled
                ? const LinearGradient(
                    colors: [Color(0xFF3A456E), Color(0xFF2C365D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFF2D3553), Color(0xFF262D48)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            border: Border.all(
              color: isEnabled
                  ? const Color(0xFF5E6D9B)
                  : const Color(0xFF444B66),
              width: 1.2,
            ),
            boxShadow: isEnabled
                ? const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ]
                : const [],
          ),
          child: Icon(
            iconData,
            size: 20,
            color: isEnabled ? Colors.white : Colors.white54,
          ),
        ),
      ),
    );
  }
}

class _PrimarySocialLinks {
  final String? linkedin;
  final String? github;
  final String? facebook;
  const _PrimarySocialLinks({this.linkedin, this.github, this.facebook});
}

_PrimarySocialLinks _primarySocialLinks(List<String> links) {
  String? byHost(String hostPart) {
    for (final link in links) {
      final host = (Uri.tryParse(link)?.host ?? '').toLowerCase();
      if (host.contains(hostPart)) return link;
    }
    return null;
  }

  return _PrimarySocialLinks(
    linkedin: byHost('linkedin'),
    github: byHost('github'),
    facebook: byHost('facebook'),
  );
}

Future<void> _openEmail(BuildContext context, String email) async {
  await _openUrl(context, 'mailto:$email');
}

Future<void> _openOpportunityEmail(
  BuildContext context,
  String? email, {
  required String subject,
  required String body,
}) async {
  if ((email ?? '').isEmpty) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email is not configured')));
    }
    return;
  }
  final encodedSubject = Uri.encodeComponent(subject);
  final encodedBody = Uri.encodeComponent(body);
  await _openUrl(
    context,
    'mailto:$email?subject=$encodedSubject&body=$encodedBody',
  );
}

Future<void> _openPhone(BuildContext context, String phone) async {
  await _openUrl(context, 'tel:$phone');
}

Future<void> _openUrl(BuildContext context, String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open $url')));
    }
  }
}
