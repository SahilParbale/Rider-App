import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'home_screen.dart';
import 'tracking_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const TrackingScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for floating effect
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primaryGreen,
            unselectedItemColor: Colors.grey.shade400,
            showSelectedLabels: false, // Clean look
            showUnselectedLabels: false,
            items: [
              _buildNavItem(Icons.home, "Home"),
              _buildNavItem(Icons.receipt_long, "Orders"),
              _buildNavItem(Icons.account_balance_wallet, "Wallet"),
              _buildNavItem(Icons.person, "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
           color: Colors.transparent, // Highlight logic inside BottomNavigationBar is default simple color change. 
           // For advanced custom highlighting (like the rounded rect in home screen earlier), we'd need CustomPainter or custom widget row.
           // Sticking to standard BottomNavItem for now but customized with the container shape if needed.
           shape: BoxShape.circle,
        ),
        child: Icon(icon),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: AppColors.successLight, // Green tint BG
          shape: BoxShape.circle, 
        ),
        child: Icon(icon, color: AppColors.primaryGreen),
      ),
      label: label,
    );
  }
}
