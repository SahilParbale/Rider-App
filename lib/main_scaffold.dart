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
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(onProfileTap: () {
        _pageController.animateToPage(
          3,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuart,
        );
      }, onOrderAccepted: () {
        _pageController.animateToPage(
          1, // Tracking Screen / Orders
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuart,
        );
      }),
      TrackingScreen(onBack: () {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuart,
        );
      }),
      const WalletScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: pages,
          ),
          if (_currentIndex != 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCustomNavItem(0, Icons.home_filled, "Home"),
                    _buildCustomNavItem(1, Icons.delivery_dining, "Orders"),
                    _buildCustomNavItem(2, Icons.account_balance_wallet, "Wallet"),
                    _buildCustomNavItem(3, Icons.person_outline, "Profile"),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomNavItem(int index, IconData icon, String label) {
    bool isSelected = _currentIndex == index;
    
    // Extra padding for edge items when inactive to balance the look
    EdgeInsets itemPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    if (!isSelected) {
       if (index == 0) {
         itemPadding = const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 8);
       } else if (index == 3) {
         itemPadding = const EdgeInsets.only(left: 8, right: 24, top: 8, bottom: 8);
       }
    }

    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuart,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: itemPadding,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF2FBF5) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: isSelected
            ? Text(
                label,
                style: GoogleFonts.barlowCondensed(
                  color: const Color(0xFF23AA49),
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              )
            : Icon(
                icon,
                color: const Color(0xFF2D2D2D),
                size: 30,
              ),
      ),
    );
  }
}
