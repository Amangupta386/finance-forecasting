import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/authentication/login_screen.dart';
import 'package:ddofinance/screens/dashBoard/dashboard.dart';
import 'package:ddofinance/screens/error/error_screen.dart';
import 'package:ddofinance/screens/projects/addProjectScreen/add_project_screen.dart';
import 'package:ddofinance/screens/projects/editProjectScreen/edit_project_screen.dart';
import 'package:ddofinance/screens/dashBoard/dashboard_and_project_datatable_screen.dart';
import 'package:ddofinance/screens/projects/projects_screen.dart';
import 'package:ddofinance/screens/resources/resources_screen.dart';
import 'package:ddofinance/screens/resources_cost/resources_cost_screen.dart';
import 'package:ddofinance/widgets/left_navigation_rail.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/providers/authentication/auth_provider.dart';
import 'package:provider/provider.dart';
import 'app_routes.dart';

/// These are global navigator keys which indicate root and shell.
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

///  A class representing the routing.
class AppRouter {
  // Define a static instance of GoRouter for routing.
  // final isAuthenticated =  Provider.of<AuthProvider>(rootNavigatorKey.currentState!.context, listen: false).auth;
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.initialScreen,
    errorPageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: const ErrorScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
    routerNeglect: true,
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
            Widget? screen;
            final isAuthenticated =
                Provider.of<AuthProvider>(context, listen: false).auth;
            if (isAuthenticated) {
              screen = LeftNavigationRail(child: child);
            } else {
              screen = const LoginScreen();
            }
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: screen,
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
                  Widget? screen;
                  final isAuthenticated =
                      Provider.of<AuthProvider>(context, listen: false).auth;
                  if (isAuthenticated) {
                    screen = const DashBoard();
                  } else {
                    screen = const LoginScreen();
                  }

                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: screen,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                }),

            GoRoute(
                path: Routes.projectScreen,
                // Define a custom transition page for the ProjectPage screen.
                pageBuilder: (context, state) {
                  Widget? screen;
                  final isAuthenticated =
                      Provider.of<AuthProvider>(context, listen: false).auth;
                  if (isAuthenticated) {
                    screen = const ProjectsScreen();
                  } else {
                    screen = const LoginScreen();
                  }
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: screen,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                  );
                },
                routes: [
                  GoRoute(
                      name: 'addProjectScreen',
                      path: Routes.addProjectScreen,
                      pageBuilder: (context, state) {
                        Widget? screen;
                        final isAuthenticated =
                            Provider.of<AuthProvider>(context, listen: false)
                                .auth;
                        if (isAuthenticated) {
                          screen = const AddProjectScreen();
                        } else {
                          screen = const LoginScreen();
                        }
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: screen,
                          transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                        );
                      }),
                  GoRoute(
                      name: 'projectChartScreen',
                      path: Routes.projectChartScreen,
                      pageBuilder: (context, state) {
                        Widget? screen;
                        final isAuthenticated =
                            Provider.of<AuthProvider>(context, listen: false)
                                .auth;
                        if (isAuthenticated) {
                          screen = const DashboardAndProjectDatatableScreen();
                        } else {
                          screen = const LoginScreen();
                        }
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: screen,
                          transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                        );
                      }),
                  GoRoute(
                      name: 'editProjectScreen',
                      path: Routes.editProjectScreen,
                      pageBuilder: (context, state) {
                        Widget? screen;
                        final isAuthenticated =
                            Provider.of<AuthProvider>(context, listen: false)
                                .auth;
                        if (isAuthenticated) {
                          screen = const EditProjectScreen();
                        } else {
                          screen = const LoginScreen();
                        }
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: screen,
                          transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                        );
                      })
                ]),
            GoRoute(
              path: Routes.resourceScreen,
              // Define a custom transition page for the ResourcesPage screen.
              pageBuilder: (context, state) {
                Widget? screen;
                final isAuthenticated =
                    Provider.of<AuthProvider>(context, listen: false).auth;
                if (isAuthenticated) {
                  screen = const ResourcesScreen();
                } else {
                  screen = const LoginScreen();
                }
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: screen,
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
                Widget? screen;
                final isAuthenticated =
                    Provider.of<AuthProvider>(context, listen: false).auth;
                if (isAuthenticated) {
                  screen = const ResourcesCostScreen();
                } else {
                  screen = const LoginScreen();
                }
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: screen,
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
