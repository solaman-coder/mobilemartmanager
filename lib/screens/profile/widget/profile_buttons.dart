// import 'package:flutter/material.dart';
// import 'package:mobilemart/routes/app_routes.dart';
// import '../../../database/fuctions/user_db.dart';
// import '../../../database/models/profile_model.dart';
// import '../change_password_screen.dart';
// import '../edit_profile_screen.dart';

// class ProfileButtons extends StatelessWidget {
//   final void Function(ProfileModel) onProfileUpdated;

//   const ProfileButtons({super.key, required this.onProfileUpdated});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () async {
//             final updatedProfile = await Navigator.push<ProfileModel>(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const EditProfileScreen(),
//               ),
//             );
//             if (updatedProfile != null) {
//               onProfileUpdated(updatedProfile);
//             }
//           },
//           child: const Text('Edit Profile'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const ChangePasswordScreen(),
//               ),
//             );
//           },
//           child: const Text('Change Password'),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             await UserDb.setLoggedIn(false);
//             // ignore: use_build_context_synchronously
//             Navigator.pushNamedAndRemoveUntil(
//                 context, AppRoutes.login, (route) => false);
//           },
//           child: const Text('Logout'),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobilemart/routes/app_routes.dart';

import '../../../database/fuctions/user_db.dart';
import '../../../database/models/profile_model.dart';

import '../change_password_screen.dart';

import '../edit_profile_screen.dart';

class ProfileButtons extends StatelessWidget {
  final void Function(ProfileModel) onProfileUpdated;

  const ProfileButtons({super.key, required this.onProfileUpdated});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.edit, color: Colors.blue),
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () async {
              final updatedProfile = await Navigator.push<ProfileModel>(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
              if (updatedProfile != null) {
                onProfileUpdated(updatedProfile);
              }
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.lock, color: Colors.orange),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              );
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () async {
              await UserDb.setLoggedIn(false);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.login, (route) => false);
            },
          ),
        ),
      ],
    );
  }
}
