import 'package:flutter/material.dart';
import 'package:proyecto_final_prograv/screens/dashboard.dart';
import 'package:proyecto_final_prograv/screens/dashboard_detailed_service.dart';
import 'screens/dashboard_detailed.dart';
import 'screens/login.dart';
import 'screens/options_server.dart';
import 'screens/options_service.dart';
import 'screens/tabbed_crud.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/':(_) => LogInPage(),
        'dashboard': (_) => DashboardPage(),
        'dashboardDetailed': (_) => DashboardDetailedPage(),
        'dashboardDetailedService': (_) => DashBoardDetailedServicePage(),
        'tabbedCrud': (_) => TabbedCrud(),
        'optionsServer': (_) => OptionsServer(),
        'optionsService': (_) => OptionsService()
      },
    );
  }
}