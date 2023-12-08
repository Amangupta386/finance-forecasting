import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/authentication/login_screen.dart';
import 'package:ddofinance/screens/dashBoard/dashboard.dart';
import 'package:ddofinance/screens/error/error_screen.dart';
import 'package:ddofinance/screens/dashBoard/dashboard_and_project_datatable_screen.dart';
import 'package:ddofinance/screens/projects/projects_screen.dart';
import 'package:ddofinance/screens/resources/resources_screen.dart';
import 'package:ddofinance/screens/resources_cost/resources_cost_screen.dart';
import 'package:ddofinance/widgets/left_navigation_rail.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_routes.dart';

/// These are global navigator keys which indicate root and shell.
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

///  A class representing the routing.
class AppRouter {
  // Define a static instance of GoRouter for routing.
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.initialScreen,
    errorPageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: const ErrorScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    redirect: (BuildContext context, GoRouterState state) async {
      final bool isAuthentication;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isAuthentication = prefs.getBool('auth') ?? false;
      if (!isAuthentication && state.matchedLocation != Routes.initialScreen) {
        return Routes.initialScreen;
      }
      if (isAuthentication && state.matchedLocation == Routes.initialScreen) {
        return Routes.dashBoardScreen;
      }
      return null;
    },
    routes: <RouteBase>[
      // Define the main application route.
      GoRoute(
        name: 'login',
        path: Routes.initialScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      // Define a nested route for the shell layout.
      ShellRoute(
          navigatorKey: shellNavigatorKey,
          pageBuilder:
              (BuildContext context, GoRouterState state, Widget child) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: LeftNavigationRail(child: child),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          },
          routes: <RouteBase>[
            // Define routes within the shell layout.
            GoRoute(
                path: Routes.dashBoardScreen,
                // Define a custom transition page for the Dashboard screen.
                pageBuilder: (context, state) {
                  var provider = Provider.of<ProjectsProvider>(context);
                  if (provider.toMoveNavigator == true) {
                    provider.setToMove(false);
                  } else {
                    provider.setToMove(provider.toMoveNavigator);
                  }
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: const DashBoard(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                }),

            GoRoute(
                path: Routes.projectScreen,
                // Define a custom transition page for the ProjectPage screen.
                pageBuilder: (context, state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: const ProjectsScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                },
                routes: [
                  GoRoute(
                      name: 'projectChartScreen',
                      path: Routes.projectChartScreen,
                      pageBuilder: (context, state) {
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const DashboardAndProjectDatatableScreen(),
                          transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                        );
                      }),
                ]),
            GoRoute(
              path: Routes.resourceScreen,
              // Define a custom transition page for the ResourcesPage screen.
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const ResourcesScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                );
              },
            ),

            GoRoute(
              path: Routes.resourceCostScreen,
              // Define a custom transition page for the ResourcesCostPage screen.
              pageBuilder: (context, state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const ResourcesCostScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                );
              },
            ),
          ])
    ],
  );

  bool removeAllRoute() {
    return GoRouter.optionURLReflectsImperativeAPIs == true;
  }
}
