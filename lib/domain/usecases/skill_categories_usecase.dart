import 'package:vivekdevfolio/domain/entities/skill_category.dart';

class SkillCategoriesUseCase {
  const SkillCategoriesUseCase();

  List<SkillCategory> build() {
    return const [
      SkillCategory(
        title: 'Mobile Development',
        iconKey: 'smartphone',
        tintKey: 'blue',
        items: [
          'Flutter',
          'Dart',
          'Android (Java, Kotlin)',
          'iOS (Swift)',
          'React Native',
          'Ionic',
          'NativeScript',
        ],
      ),
      SkillCategory(
        title: 'Tools & Platforms',
        iconKey: 'tools',
        tintKey: 'slate',
        items: [
          'Android Studio',
          'Xcode',
          'VS Code',
          'Git',
          'GitHub',
          'GitLab',
          'Bitbucket',
          'JIRA',
          'Confluence',
        ],
      ),
      SkillCategory(
        title: 'Architecture & Design',
        iconKey: 'architecture',
        tintKey: 'blue',
        items: [
          'Clean Architecture',
          'Domain-Driven Design (DDD)',
          'MVVM',
          'SOLID Principles',
          'Modular Architecture',
          'Reusable Component Design',
          'Scalable System Design',
        ],
      ),
      SkillCategory(
        title: 'Backend & Database',
        iconKey: 'storage',
        tintKey: 'purple',
        items: [
          'Firebase',
          'REST APIs',
          'GraphQL',
          'NodeJs',
          'MySQL',
          'Mongodb',
          'SQLite',
          'Hive',
          'Isar',
          'Firebase Firestore',
          'Firebase Realtime Database',
        ],
      ),
      SkillCategory(
        title: 'API & Networking',
        iconKey: 'cloud',
        tintKey: 'teal',
        items: [
          'REST APIs',
          'GraphQL',
          'HTTP Client',
          'WebSockets',
          'Response Caching',
          'Pagination',
          'Token Management',
        ],
      ),
      SkillCategory(
        title: 'Payment Systems',
        iconKey: 'payment',
        tintKey: 'green',
        items: [
          'In-app purchases (Google Play Store & Apple App Store)',
          'Ezetap POS',
          'Paytm',
          'Razorpay',
          'Paygate',
          'OpenPay',
        ],
      ),
      SkillCategory(
        title: 'Authentication & Security',
        iconKey: 'security',
        tintKey: 'red',
        items: [
          'OAuth 2.0',
          'OIDC Flows',
          'JWT Handling',
          'Biometric Authentication',
          'Secure Token Storage',
        ],
      ),
      SkillCategory(
        title: 'CI/CD & DevOps',
        iconKey: 'cicd',
        tintKey: 'blueSoft',
        items: [
          'CI/CD Pipelines',
          'Jenkins',
          'GitHub Actions',
          'Bitrise',
          'CodeMagic',
          'Fastlane',
          'CircleCI',
        ],
      ),
      SkillCategory(
        title: 'AI Productivity Tools',
        iconKey: 'ai',
        tintKey: 'slate',
        items: ['GitHub Copilot', 'Cursor', 'WindSurf', 'Claude', 'Gemini'],
      ),
    ];
  }
}
