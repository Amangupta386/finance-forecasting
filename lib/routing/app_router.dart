import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/authentication/login_screen.dart';
import 'package:ddofinance/screens/dashBoard/dashboard.dart';
import 'package:ddofinance/screens/error/error_screen.dart';
import 'package:ddofinance/screens/projects/addProjectScreen/add_project_screen.dart';
import 'package:ddofinance/screens/projects/editProjectScreen/edit_project_screen.dart';
import 'package:ddofinance/screens/projects/project_chart_screen.dart';
import 'package:ddofinance/screens/projects/projects_screen.dart';
import 'package:ddofinance/screens/resources/resources_screen.dart';
import 'package:ddofinance/screens/resources_cost/resources_cost_screen.dart';
import 'package:ddofinance/widgets/left_navigation_rail.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/providers/authentication/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_routes.dart';

/// These are global navigator keys which indicate root and shell.
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

///  A class representing the routing.
class AppRouter {
  // Define a static instance of GoRouter for routing.
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.initialScreen,
    errorBuilder: (context, state) => const ErrorScreen(),
    routerNeglect: true,
    routes: <RouteBase>[
      // Define the main application route.
      GoRoute(
        path: Routes.initialScreen,
        builder: (BuildContext context, GoRouterState state) {
          final isAuthenticated =
              Provider.of<AuthProvider>(context, listen: false).auth;
          final Widget screen;
          if (!isAuthenticated) {
            screen = LoginScreen(
              onSign: () => !isAuthenticated,
            );
          } else {
            screen = const ErrorScreen();
          }
          return screen;
        },
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: LoginScreen(
            onSign: () {},
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      // Define a nested route for the shell layout.
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder:
              (BuildContext context, GoRouterState state, Widget child) =>
                  CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: LeftNavigationRail(child: child),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  ),
          routes: <RouteBase>[
            // Define routes within the shell layout.
            GoRoute(
                path: Routes.dashBoardScreen,
                // Define a custom transition page for the Dashboard screen.
                pageBuilder: (context, state) {
                  var provider =Provider.of<ProjectsProvider>(context);
                  if(provider.toMove == true) {
                    provider.setToMove(false);
                  }else {
                    provider.setToMove(provider.toMove);
                  }
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: DashBoard(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                }),

            GoRoute(
                path: Routes.projectScreen,
                // Define a custom transition page for the ProjectPage screen.
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const ProjectsScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                routes: [
                  GoRoute(
                    name: 'addProjectScreen',
                    path: Routes.addProjectScreen,
                    builder: (BuildContext context, GoRouterState state) {
                      return const AddProjectScreen();
                    },
                  ),
                  GoRoute(
                    name: 'projectChartScreen',
                    path: Routes.projectChartScreen,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ProjectChartScreen();
                    },
                  ),
                  GoRoute(
                      name: 'editProjectScreen',
                      path: Routes.editProjectScreen,
                      builder: (BuildContext context, GoRouterState state) {
                        return const EditProjectScreen();
                      })
                ]),
            GoRoute(
              path: Routes.resourceScreen,
              // Define a custom transition page for the ResourcesPage screen.
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const ResourcesScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),

            GoRoute(
              path: Routes.resourceCostScreen,
              // Define a custom transition page for the ResourcesCostPage screen.
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: const ResourcesCostScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
          ])
    ],
  );
}
