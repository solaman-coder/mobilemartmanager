import 'package:flutter/material.dart';
import 'package:mobilemart/routes/app_routes.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> guidePages = [
    {
      'image': 'assets/images/homescreen.png',
      'title': 'Welcome to Mobile Mart',
      'desc':
          'This is the home screen. Here you can see your profile picture and name. To set this up, go to the profile section. You can see four buttons: Add Expense, Money Flow, Add Stock, and Customers. Tap any button to go to that page and explore its features. On the bottom right, you will see a "View All" option, which leads to the respective screen where you can view more details.'
    },
    {
      'image': 'assets/images/inventory.png',
      'title': 'Add & manage products',
      'desc':
          'On the top right, there is an add button that allows you to add products. In the search bar, you can search for products. For example, if you enter "14" it will show items like a front camera with 14 MP. Below, there is a "+" button to add brands.'
    },
    {
      'image': 'assets/images/inventoryfeatures.png',
      'title': 'manage products',
      'desc':
          'You can scroll left and right to view added brands. Products are displayed as cards—tap a card to view its specifications. On this page, there is a pencil icon and a bag icon. Tapping the pencil allows you to edit, delete, update, or change quantity. Tapping the bag icon adds the product to the cart, and you can add multiple products.'
    },
    {
      'image': 'assets/images/productdisbleandenable.png',
      'title': 'product disable and enable',
      'desc':
          'If you long press on a brand icon (e.g., Apple), you can see options to edit or delete it. If you delete a brand that has existing products, those products will be disabled, and you cannot perform any actions on them. To enable them again, add the same brand name using the "Add Brand" option.'
    },
    {
      'image': 'assets/images/cartscreen.png',
      'title': 'cartscreen',
      'desc':
          'Here you can see all the products added to your cart. You can increase or decrease quantity, remove products by clicking the remove button, and proceed to checkout, which will take you to the customers page.'
    },
    {
      'image': 'assets/images/customerdetails.png',
      'title': 'customer page',
      'desc':
          'Here you can enter customer details. Press "Save and Continue" to move to the payment screen.'
    },
    {
      'image': 'assets/images/payamentscreen.png',
      'title': 'paymentscren',
      'desc': 'Here you can complete the payment process.'
    },
    {
      'image': 'assets/images/profilescreen.png',
      'title': 'profile setup',
      'desc':
          'Here you can set up your profile, edit your details, change your password, and log out using the buttons provided.'
    },
    {
      'image': 'assets/images/profilesetupscreen.png',
      'title': 'profile data',
      'desc':
          'Click on the profile image to select a new image from your device, and enter your phone number and name.'
    },
    {
      'image': 'assets/images/profitscreen.png',
      'title': 'moneyflow',
      'desc':
          'In this screen, you can track your profit and filter results by date. Click on the month to open a dropdown menu, select the desired month, and filter the profit. You can also view additional expenses such as building rent, which can be added using the "Add Expense" button.'
    },
    {
      'image': 'assets/images/login page.png',
      'title': 'login screen',
      'desc':
          'Enter the credentials you created on the registration screen to log in.'
    },
  ];

  void onNextPressed() {
    if (currentPage < guidePages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: _controller,
            itemCount: guidePages.length,
            onPageChanged: (index) => setState(() => currentPage = index),
            itemBuilder: (context, index) {
              final page = guidePages[index];
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(page['image']!, height: 300),
                    const SizedBox(height: 30),
                    Text(
                      page['title']!,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      page['desc']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),

          // Skip button
          Positioned(
            top: 40,
            right: 16,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ),
        ],
      ),

      // Bottom Next/Start button
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onNextPressed,
          child: Text(currentPage == guidePages.length - 1 ? "Start" : "Next"),
        ),
      ),
    );
  }
}
