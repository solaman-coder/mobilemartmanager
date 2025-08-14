import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  final String? name;

  const WelcomeHeader({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // aligns left
      children: [
        const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(149, 26, 24, 24),
          ),
        ),
        Text(
          name != null && name!.isNotEmpty ? name! : 'User',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
