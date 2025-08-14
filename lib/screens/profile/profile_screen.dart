import 'dart:io';

import 'package:flutter/material.dart';
import '../../database/fuctions/profile_db.dart';
import '../../database/models/profile_model.dart';
import '../../theme/color_theme.dart';

import '../home/widgets/bottomnavigation.dart';
import 'widget/profile_buttons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel? profile;

  @override
  void initState() {
    super.initState();
    profile = ProfileDb.getProfile();
  }

  void _updateProfile(ProfileModel updatedProfile) {
    setState(() {
      profile = updatedProfile;
    });
  }

  void loadProfile() {
    final data = ProfileDb.getProfile();
    setState(() {
      profile = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasProfile = profile != null;
    final hasImage = hasProfile && profile!.image.isNotEmpty;
    // final imageProvider = hasImage
    //     ? FileImage(File(profile!.image))
    //     : const AssetImage('assets/images/download (2).jpeg') as ImageProvider;

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("My Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // CircleAvatar(
              //   radius: 60,
              //   backgroundImage: imageProvider,
              // ),
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    hasImage ? FileImage(File(profile!.image)) : null,
                backgroundColor: Colors.grey.shade200,
                child: !hasImage
                    ? const Icon(Icons.person, size: 60, color: Colors.grey)
                    : null,
              ),
              // if (!hasImage)
              //   Positioned(
              //     bottom: 0,
              //     right: 0,
              //     child: CircleAvatar(
              //       backgroundColor: Colors.white,
              //       radius: 18,
              //       child: Icon(Icons.camera_alt,
              //           size: 20, color: AppColors.primary),
              //     ),
              //   ),
              const SizedBox(height: 20),
              if (hasProfile) ...[
                Text(
                  profile!.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  profile!.phone,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  profile!.shopName,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 10),
              ] else ...[
                const Text(
                  "No profile data found",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
              const SizedBox(height: 20),
              ProfileButtons(onProfileUpdated: _updateProfile),
            ],
          ),
        ),
      ),
    );
  }
}
