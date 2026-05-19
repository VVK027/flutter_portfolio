import 'package:go_router/go_router.dart';
import 'package:vivekdevfolio/presentation/extensions/portfolio_section_enum.dart';
import 'package:vivekdevfolio/presentation/portfolio/screen/portfolio_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PortfolioPage(),
      routes: [
        GoRoute(
          path: 'section/:id',
          builder: (c, s) {
            final section = PortfolioSectionEnum.fromId(s.pathParameters['id']);
            return PortfolioPage(initialSection: section?.id);
          },
        ),
      ],
    ),
  ],
);
