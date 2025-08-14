import 'package:flutter/material.dart';
import 'package:mobilemart/routes/app_routes.dart';
import 'package:mobilemart/theme/color_theme.dart';
import '../../database/fuctions/user_db.dart';
import 'widgets/login_fields.dart';
import 'widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final enteredEmail = emailController.text.trim();
    final enteredPassword = passwordController.text.trim();

    final isValid = UserDb.validateUser(enteredEmail, enteredPassword);

    if (isValid) {
      await UserDb.setLoggedIn(true);
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('invalid credentials')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Placeholder for the curved image
            Container(
              height: 500,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/loginimage.png"), // your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Log In",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  LoginFields(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  const SizedBox(height: 30),
                  LoginButton(onPressed: login),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // TODO: add register navigation
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
