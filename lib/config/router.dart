import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/presentation/homepage/screens/portfolioOverviewScreen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
class AppRouter {
  GoRouter get router => _goRouter;

  AppRouter();

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => PortfolioOverviewScreen()
      ),
      GoRoute(
        path: '/test/:title',
        builder: (context, state) => MyHomePage(
          title: state.pathParameters['title']!,
        ),
      ),
    ],
  );
}
