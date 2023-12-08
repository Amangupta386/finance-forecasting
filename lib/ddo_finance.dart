import 'package:ddofinance/providers/authentication/auth_provider.dart';
import 'package:ddofinance/providers/navigation_rail_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/resources/resources_provider.dart';
import 'package:ddofinance/providers/resources_cost/resources_cost_data_provider.dart';
import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/theme/theme.dart';
import 'package:ddofinance/widgets/custom_scroll_behaviour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final ThemeData themeData = AppTheme.buildTheme();

class DdoFinance extends StatelessWidget {
  const DdoFinance({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProjectsProvider()),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResourceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationRailProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResourcesCostDataProvider(),
        ),
      ],
      // create: (context)=>Auth(),
      child: MaterialApp.router(
        scrollBehavior: MyCustomScrollBehavior(),
        theme: themeData,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
