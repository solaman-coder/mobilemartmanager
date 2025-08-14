import 'package:flutter/material.dart';

class ProfileFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const ProfileFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    final inputStyle = InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF5F6FA),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );

    return Column(
      children: [
        TextField(
            controller: nameController,
            decoration: inputStyle.copyWith(hintText: "Name")),
        const SizedBox(height: 12),
        TextField(
            controller: emailController,
            decoration: inputStyle.copyWith(hintText: "Email")),
        const SizedBox(height: 12),
        TextField(
            controller: phoneController,
            decoration: inputStyle.copyWith(hintText: "Phone")),
      ],
    );
  }
}
