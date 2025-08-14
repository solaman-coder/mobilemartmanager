import 'package:flutter/material.dart';
import 'package:mobilemart/routes/app_routes.dart';
import 'package:mobilemart/screens/splashScreen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MobilemartManagerApp());
}

class MobilemartManagerApp extends StatelessWidget {
  const MobilemartManagerApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Mart Manager',
      theme: AppTheme.lightTheme,
      home: const SplashRedirectScreen(),
      routes: AppRoutes.routes,
    );
  }
}
