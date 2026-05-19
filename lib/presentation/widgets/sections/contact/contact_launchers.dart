import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openContactEmail(BuildContext context, String email) async {
  await openContactUrl(context, 'mailto:$email');
}

Future<void> openOpportunityEmail(
  BuildContext context,
  String? email, {
  required String subject,
  required String body,
}) async {
  if ((email ?? '').isEmpty) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email is not configured')),
      );
    }
    return;
  }
  final encodedSubject = Uri.encodeComponent(subject);
  final encodedBody = Uri.encodeComponent(body);
  await openContactUrl(
    context,
    'mailto:$email?subject=$encodedSubject&body=$encodedBody',
  );
}

Future<void> openContactPhone(BuildContext context, String phone) async {
  await openContactUrl(context, 'tel:$phone');
}

Future<void> openContactUrl(BuildContext context, String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }
}

String contactCopyrightText() {
  final year = DateTime.now().year;
  return '© $year Vivek Kumar. All rights reserved.';
}
