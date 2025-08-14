import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mobilemart/database/models/profile_model.dart';

import '../../database/fuctions/profile_db.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final shopNameController = TextEditingController();
  String imagePath = '';

  @override
  void initState() {
    super.initState();
    final profile = ProfileDb.getProfile();
    print('Loaded profile: $profile');
    if (profile != null) {
      nameController.text = profile.name;
      phoneController.text = profile.phone;
      imagePath = profile.image;
      shopNameController.text = profile.shopName;
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imagePath = picked.path;
      });
    }
  }

  Future<void> _saveProfile() async {
    final updatedProfile = ProfileModel(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      image: imagePath,
      shopName: shopNameController.text.trim(),
    );

    await ProfileDb.updateProfile(updatedProfile);
    print('Profile saved: $updatedProfile');
    Navigator.pop(context, updatedProfile); // Go back to profile screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image Picker
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: imagePath.isNotEmpty
                    ? FileImage(File(imagePath))
                    : const AssetImage('assets/images/download (2).jpeg')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),

            // Name Field
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Phone Field
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            // TextField(
            //   controller: shopNameController,
            //   decoration: const InputDecoration(
            //     labelText: 'Shop Name',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 16),

            // Save Button
            ElevatedButton.icon(
              onPressed: _saveProfile,
              icon: const Icon(Icons.save),
              label: const Text('Save Changes'),
            )
          ],
        ),
      ),
    );
  }
}
