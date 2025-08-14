import 'package:flutter/material.dart';
import '../../database/fuctions/user_db.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String errorText = '';

  Future<void> _changePassword() async {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    final isCurrentCorrect = UserDb.checkCurrentPassword(currentPassword);
    if (!isCurrentCorrect) {
      setState(() {
        errorText = 'Current password is incorrect.';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        errorText = 'New password and confirmation do not match.';
      });
      return;
    }

    if (newPassword.isEmpty || newPassword.length < 4) {
      setState(() {
        errorText = 'New password must be at least 4 characters.';
      });
      return;
    }

    await UserDb.updatePassword(newPassword);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated successfully!')),
    );
    Navigator.pop(context); // Back to Profile screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorText.isNotEmpty)
              Text(
                errorText,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 12),

            // Current Password
            TextField(
              controller: currentPasswordController,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),

            // New Password
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),

            // Confirm Password
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _changePassword,
              icon: const Icon(Icons.lock_reset),
              label: const Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
