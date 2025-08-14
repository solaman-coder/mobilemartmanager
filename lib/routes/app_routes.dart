import 'package:flutter/material.dart';
import 'package:mobilemart/screens/addstock/add_stock_screen.dart';
import 'package:mobilemart/screens/customers/customersales_screen.dart';
import 'package:mobilemart/screens/guidescreen/guidescreen.dart';
import 'package:mobilemart/screens/home/home_screen.dart';
import 'package:mobilemart/screens/home/widgets/lowstockalert.dart';
import 'package:mobilemart/screens/inventory/inventory_screen.dart';
import 'package:mobilemart/screens/login/loginscreen.dart';
import 'package:mobilemart/screens/profit_pie/profit_pie_screen.dart';
import 'package:mobilemart/screens/register/register_screen.dart';

import '../screens/cart/cart_screen.dart';
import '../screens/checkout/checkout_screen.dart';
import '../screens/expences/expense_screen.dart';
import '../screens/profile/change_password_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String addstock = '/addstock';
  static const String inventory = '/inventory';
  static const String editProfile = '/editProfile';
  static const String changePassword = '/changePassword';
  static const String profile = '/profile';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String coustomers = '/CustomerSalesScreen';
  static const String lowstock = '/LowStockAlert';
  static const String expence = '/expenceScreen';
  static const String profitpie = '/profitPie';
  static const String guide = '/guide';
  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (_) => const HomeScreen(),
    register: (_) => const RegisterScreen(),
    addstock: (_) => const AddStockScreen(),
    inventory: (_) => const InventoryScreen(),
    editProfile: (_) => const EditProfileScreen(),
    changePassword: (_) => const ChangePasswordScreen(),
    profile: (_) => const ProfileScreen(),
    cart: (_) => const CartScreen(),
    checkout: (_) => const CheckoutScreen(),
    coustomers: (_) => const CustomerSalesScreen(),
    lowstock: (_) => const LowStockAlert(),
    expence: (_) => const ExpenseScreen(),
    profitpie: (_) => const ProfitPieScreen(),
    guide: (_) => const GuideScreen(),
  };
}
