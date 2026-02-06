import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Green Header
          // List Content (At bottom of stack so it scrolls behind header)
          // List Content (At bottom of stack so it scrolls behind header)
          // List Content (At bottom of stack so it scrolls behind header)
          // List Content (At bottom of stack so it scrolls behind header)
          ListView(
            padding: const EdgeInsets.only(top: 120, left: 16, right: 16), // Content starts below the compact header
            children: [
              _buildNotificationItem(
                title: "Payment Received",
                message: "Your withdrawal of \$250 has been processed successfully",
                time: "2 hours ago",
                icon: Icons.attach_money,
                iconColor: const Color(0xFF2E7D32), // Dark Green
                bgColor: const Color(0xFFE8F5E9), // Light Green
              ),
              _buildNotificationItem(
                title: "New Order Available",
                message: "A new delivery request is waiting in your area",
                time: "3 hours ago",
                icon: Icons.inbox,
                iconColor: const Color(0xFF1976D2), // Blue
                bgColor: const Color(0xFFE3F2FD), // Light Blue
              ),
              _buildNotificationItem(
                title: "Weekend Bonus!",
                message: "Earn 20% extra on all deliveries this weekend",
                time: "5 hours ago",
                icon: Icons.card_giftcard,
                iconColor: const Color(0xFFF57C00), // Orange
                bgColor: const Color(0xFFFFF3E0), // Light Orange
              ),
              _buildNotificationItem(
                title: "Due Payment Reminder",
                message: "You have \$189 due to the company. Settle now to avoid penalties",
                time: "1 day ago",
                icon: Icons.error_outline,
                iconColor: const Color(0xFFD32F2F), // Red
                bgColor: const Color(0xFFFFEBEE), // Light Red
              ),
               _buildNotificationItem(
                title: "Order Completed",
                message: "Order #01234 delivered successfully. You earned \$15.50",
                time: "1 day ago",
                icon: Icons.check_box_outlined,
                iconColor: const Color(0xFF1976D2), // Blue
                bgColor: const Color(0xFFE3F2FD), // Light Blue
              ),
               _buildNotificationItem(
                title: "Milestone Achieved!",
                message: "Congratulations! You've completed 150 deliveries",
                time: "2 days ago",
                icon: Icons.emoji_events_outlined,
                iconColor: const Color(0xFF2E7D32), // Green
                bgColor: const Color(0xFFE8F5E9), // Light Green
              ),
              const SizedBox(height: 20),
            ],
          ),

          // Green Header (At top of stack so it covers content)
          Positioned(
            top: 0,
            left: -5,
            right: -5,
            child: Container(
              // height removed to wrap content purely
              decoration: const BoxDecoration(
                color: AppColors.headerGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24), // Increased bottom padding slightly for look
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically in center
                    children: [
                       // Back Button
                       GestureDetector(
                         onTap: () => Navigator.pop(context),
                         child: Container(
                           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                           decoration: BoxDecoration(
                             color: const Color(0xFFF2FBF5),
                             borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                               BoxShadow(
                                 color: Colors.black.withOpacity(0.1), 
                                 blurRadius: 4, 
                                 offset: const Offset(0, 2),
                               ),
                             ],
                           ),
                           child: Text(
                             "BACK",
                             style: GoogleFonts.barlowCondensed(
                               color: const Color(0xFF23AA49),
                               fontWeight: FontWeight.w700,
                               fontSize: 22,
                             ),
                           ),
                         ),
                       ),
                      const Spacer(),
                      // Notifications Title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min, // Wrap height
                        children: [
                          Text(
                            "Notifications",
                            style: GoogleFonts.barlowCondensed( 
                              fontSize: 32, 
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "All caught up!",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                 const SizedBox(height: 8),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
