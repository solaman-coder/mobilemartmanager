import 'package:flutter/material.dart';
import 'package:mobilemart/database/fuctions/user_db.dart';
import 'package:mobilemart/routes/app_routes.dart';
import 'package:mobilemart/screens/register/widget/register_button.dart';
import 'package:mobilemart/screens/register/widget/register_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // late Box<UserModel> userBox;

  // @override
  // void initState() {
  //   super.initState();
  //   userBox = Hive.box<UserModel>('userBox');
  // }

  void register() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both fields')),
      );
      return;
    }

    // userBox.put('user', UserModel(email: email, password: password));
    UserDb.saveUser(email, password);
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   AppRoutes.login,
    //   (route) => false,
    // );
    Navigator.pushReplacementNamed(context, AppRoutes.guide);
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
                  image: AssetImage("assets/images/loginimage.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3A4B),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  RegisterFields(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  const SizedBox(height: 30),
                  RegisterButton(onPressed: register),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
