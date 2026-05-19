import 'package:flutter/material.dart';

/// Hidden [komarev](https://komarev.com/ghpvc/) ping via GitHub Camo (README URL).
///
/// Uses [Image.network] only (Flutter SDK). On web, [WebHtmlElementStrategy.prefer]
/// must be used so the badge loads as a DOM `<img>` (avoids CORS). Do not use
/// [WebHtmlElementStrategy.fallback] here — it fetches via XHR and Camo blocks it.
class GitHubProfileViewCounter extends StatelessWidget {
  const GitHubProfileViewCounter({super.key});

  static const badgeUrl =
      'https://camo.githubusercontent.com/92c2ca2a9b50992c1c443b3a1319e404571284d2ebe8f101d14db9e26dac1479/68747470733a2f2f6b6f6d617265762e636f6d2f67687076632f3f757365726e616d653d564b303237266c6162656c3d50726f66696c65253230566965777326636f6c6f723d306537356236267374796c653d666c6174';

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ExcludeSemantics(
        child: Opacity(
          opacity: 0,
          child: SizedBox(
            width: 1,
            height: 1,
            child: Image.network(
              badgeUrl,
              width: 1,
              height: 1,
              fit: BoxFit.contain,
              webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}
