import 'package:flutter/material.dart';
import 'package:second_ecommerce_app_flutter/utils/app_theme.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_router.dart';
import 'package:second_ecommerce_app_flutter/utils/route/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.bottomNavbar,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}