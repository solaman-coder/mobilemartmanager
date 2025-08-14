// import 'package:flutter/material.dart';
// import 'package:mobilemart/database/fuctions/user_db.dart';
// import 'package:mobilemart/hive/hive_init.dart';
// import 'package:mobilemart/routes/app_routes.dart';

// class SplashRedirectScreen extends StatefulWidget {
//   const SplashRedirectScreen({super.key});

//   @override
//   State<SplashRedirectScreen> createState() => _SplashRedirectScreenState();
// }

// class _SplashRedirectScreenState extends State<SplashRedirectScreen> {
//   @override
//   void initState() {
//     super.initState();
//     redirectUser();
//   }

//   Future<void> redirectUser() async {
//     final hasUser = await initHive();
//     final isLoggedIn = await UserDb.isLoggedIn();

//     final targetRoute = hasUser
//         ? (isLoggedIn ? AppRoutes.home : AppRoutes.login)
//         : AppRoutes.register;

//     // Clear the stack
//     Navigator.pushNamedAndRemoveUntil(context, targetRoute, (route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobilemart/database/fuctions/user_db.dart';
import 'package:mobilemart/hive/hive_init.dart';
import 'package:mobilemart/routes/app_routes.dart';

class SplashRedirectScreen extends StatefulWidget {
  const SplashRedirectScreen({super.key});

  @override
  State<SplashRedirectScreen> createState() => _SplashRedirectScreenState();
}

class _SplashRedirectScreenState extends State<SplashRedirectScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.delayed(const Duration(milliseconds: 500), () {
      redirectUser();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      redirectUser(); // re-check on resume
    }
  }

  Future<void> redirectUser() async {
    if (!mounted) return;

    final hasUser = await initHive();
    final isLoggedIn = await UserDb.isLoggedIn();

    final targetRoute = hasUser
        ? (isLoggedIn ? AppRoutes.home : AppRoutes.login)
        : AppRoutes.register;

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, targetRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
