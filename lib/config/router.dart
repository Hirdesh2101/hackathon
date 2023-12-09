import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon/presentation/homepage/screens/portfolioOverviewScreen.dart';
import 'package:hackathon/presentation/redeemCoins/screen/redem_coins.dart';

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
        path: '/redeem',
        builder: (context, state) => RedeemScreen()
      ),
    ],
  );
}
