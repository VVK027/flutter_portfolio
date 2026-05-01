import 'package:flutter/material.dart';

class SectionShell extends StatelessWidget {
  final String title;
  final Widget child;
  const SectionShell({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pad = constraints.maxWidth > 900
            ? 38.0
            : (constraints.maxWidth > 600 ? 16.0 : 4.0);
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 24),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF20232D))),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                child,
              ],
            ),
          ),
        );
      },
    );
  }
}
