import 'package:go_router/go_router.dart';
import 'package:vivek_portfolio/presentation/portfolio/screen/portfolio_page.dart';


final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const PortfolioPage(),
      routes: [
        GoRoute(
          path: 'section/:id',
          builder: (c, s) => PortfolioPage(initialSection: s.pathParameters['id']),
        ),
      ],
    ),
  ],
);
