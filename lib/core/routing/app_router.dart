import 'package:go_router/go_router.dart';
import 'package:vivek_portfolio/application/portfolio/portfolio_sections.dart';
import 'package:vivek_portfolio/presentation/portfolio/screen/portfolio_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PortfolioPage(),
      routes: [
        GoRoute(
          path: 'section/:id',
          builder: (c, s) {
            final section = PortfolioSection.fromId(s.pathParameters['id']);
            return PortfolioPage(initialSection: section?.id);
          },
        ),
      ],
    ),
  ],
);
