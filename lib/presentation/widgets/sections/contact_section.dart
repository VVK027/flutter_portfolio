import 'package:flutter/material.dart';
import 'package:vivekdevfolio/core/theme/app_colors.dart';
import 'package:vivekdevfolio/domain/entities/contact_info.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/contact/contact_info_card.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/contact/contact_launchers.dart';
import 'package:vivekdevfolio/presentation/widgets/sections/contact/opportunity_card.dart';

class ContactSection extends StatelessWidget {
  final ContactInfo viewData;
  const ContactSection({super.key, required this.viewData});

  static const _columnGap = 14.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 800;

        final contactCard = ContactInfoCard(
          viewData: viewData,
          stretchContent: !compact,
        );

        final fullTimeCard = OpportunityCard(
          icon: Icons.badge_outlined,
          title: 'Full-Time Position',
          message:
              'Looking for a dedicated Flutter developer to join your team? I am open to full-time opportunities.',
          bullets: const [
            'Immediate availability',
            'Remote or On-site',
          ],
          cta: 'Discuss Opportunity',
          onTap: () => openOpportunityEmail(
            context,
            viewData.email,
            subject: 'Full-Time Flutter Opportunity',
            body:
                'Hi Vivek,\n\nI would like to discuss a full-time Flutter role with you.\n\nThanks.',
          ),
          expandVertically: !compact,
        );

        final freelanceCard = OpportunityCard(
          icon: Icons.description_outlined,
          title: 'Freelance Project',
          message:
              'Have a mobile app project? Let us discuss how I can help bring your idea to life.',
          bullets: const [
            'Flexible engagement',
            'Quality delivery',
          ],
          cta: 'Start a Conversation',
          onTap: () => openOpportunityEmail(
            context,
            viewData.email,
            subject: 'Freelance Mobile Project Discussion',
            body:
                'Hi Vivek,\n\nI would like to discuss a freelance mobile project with you.\n\nThanks.',
          ),
          expandVertically: !compact,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (compact) ...[
              contactCard,
              const SizedBox(height: _columnGap),
              fullTimeCard,
              const SizedBox(height: _columnGap),
              freelanceCard,
            ] else
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: contactCard),
                    const SizedBox(width: _columnGap),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: fullTimeCard),
                          const SizedBox(height: _columnGap),
                          Expanded(child: freelanceCard),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                contactCopyrightText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.appColors.textMuted,
                  fontSize: 11.5,
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
