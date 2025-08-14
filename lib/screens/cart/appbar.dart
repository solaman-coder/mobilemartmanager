import 'package:flutter/material.dart';
import 'package:mobilemart/routes/app_routes.dart';
import 'package:mobilemart/theme/color_theme.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: AppColors.background),
      title: Text(
        title,
        style: TextStyle(color: AppColors.background),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.inventory,
              (route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back)),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
