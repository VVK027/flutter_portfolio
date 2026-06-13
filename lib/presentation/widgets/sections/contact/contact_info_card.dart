import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/constants/portfolio_icons.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/contact_info.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/contact/contact_launchers.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/contact/social_connect_tile.dart';

class ContactInfoCard extends StatelessWidget {
  final ContactInfo viewData;
  final bool stretchContent;

  const ContactInfoCard({
    super.key,
    required this.viewData,
    this.stretchContent = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [colors.contactGradientStart, colors.contactGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: colors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          if (viewData.hasEmail)
            ContactRow(
              icon: Icons.email_outlined,
              label: 'EMAIL',
              value: viewData.email!,
              tint: const Color(0xFF2F79FF),
              onTap: () => openContactEmail(context, viewData.email!),
            ),
          if (viewData.hasPhone) ...[
            const SizedBox(height: 8),
            ContactRow(
              icon: Icons.call_outlined,
              label: 'PHONE',
              value: viewData.phone!,
              tint: const Color(0xFFB746FF),
              onTap: () => openContactPhone(context, viewData.phone!),
            ),
          ],
          const SizedBox(height: 8),
          ContactRow(
            icon: Icons.location_on_outlined,
            label: 'LOCATION',
            value: viewData.location,
            tint: const Color(0xFF8D6BFF),
            onTap: null,
          ),
          if (stretchContent) const Spacer(),
          Divider(color: colors.sectionBorder, height: 24),
          Text(
            'CONNECT ON SOCIAL',
            style: TextStyle(
              color: colors.textMuted,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 10),
          ..._socialTiles(context, viewData),
        ],
      ),
    );
  }

  List<Widget> _socialTiles(BuildContext context, ContactInfo viewData) {
    final links = viewData.primaryLinks;
    final tiles = <Widget>[];

    void addTile({
      required String? url,
      required String assetPath,
      required String label,
      required String subtitle,
    }) {
      if (url == null) return;
      if (tiles.isNotEmpty) tiles.add(const SizedBox(height: 8));
      tiles.add(
        SocialConnectTile(
          assetPath: assetPath,
          platformLabel: label,
          subtitle: subtitle,
          onTap: () => openContactUrl(context, url),
        ),
      );
    }

    addTile(
      url: links.linkedin,
      assetPath: PortfolioIcons.linkedin.assetPath,
      label: 'LINKEDIN',
      subtitle: 'Connect with me',
    );
    addTile(
      url: links.github,
      assetPath: PortfolioIcons.github.assetPath,
      label: 'GITHUB',
      subtitle: 'View my repositories',
    );
    addTile(
      url: links.facebook,
      assetPath: PortfolioIcons.facebook.assetPath,
      label: 'FACEBOOK',
      subtitle: 'Follow my updates',
    );
    addTile(
      url: links.whatsapp,
      assetPath: PortfolioIcons.whatsapp.assetPath,
      label: 'WHATSAPP',
      subtitle: 'Message me directly',
    );

    return tiles;
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color tint;
  final VoidCallback? onTap;

  const ContactRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.tint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: tint.withValues(alpha: 0.18),
              child: Icon(icon, size: 16, color: tint),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: colors.textMuted,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
