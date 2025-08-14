import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilemart/database/models/profile_model.dart';
import 'package:mobilemart/screens/home/widgets/actionbutton.dart';
import 'package:mobilemart/screens/home/widgets/bottomnavigation.dart';
import 'package:mobilemart/screens/home/widgets/lowstockalert.dart';
import 'package:mobilemart/screens/home/widgets/recentsales.dart';
import 'package:mobilemart/screens/home/widgets/salesoverviewcard.dart';
import 'package:mobilemart/screens/home/widgets/welcomeheader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: Hive.box<ProfileModel>('profileBox').listenable(),
          builder: (context, Box<ProfileModel> box, _) {
            final profile = box.get('user_profile');
            return WelcomeHeader(name: profile?.name);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<ProfileModel>('profileBox').listenable(),
              builder: (context, Box<ProfileModel> box, _) {
                final profile = box.get('user_profile');
                if (profile != null && profile.image.isNotEmpty) {
                  return CircleAvatar(
                    backgroundImage: FileImage(
                      File(profile.image),
                    ),
                  );
                } else {
                  return const CircleAvatar(
                    child: Icon(Icons.person),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            SalesOverviewCard(),
            const SizedBox(height: 15),
            SizedBox(height: 15),
            const ActionButtonsRow(),
            const SizedBox(height: 20),
            const LowStockAlert(),
            const SizedBox(height: 20),
            const RecentSalesList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
