import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'notifications_screen.dart';
import 'vehicle_details_screen.dart';
import 'payment_methods_screen.dart';
import 'privacy_security_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Green Header
          Positioned(
            top: 0,
            left: -5,
            right: -5,
            child: Container(
              height: 180,
              decoration: const BoxDecoration(
                color: AppColors.headerGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top Content (Header + Floating Card)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    children: [
                      // Header Row
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                            Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "My Profile",
                                 style: GoogleFonts.barlowCondensed(
                                   fontSize: 32,
                                   fontWeight: FontWeight.w700,
                                   color: Colors.white,
                                 ),
                               ),
                               Text(
                                 "Personal details & settings",
                                 style: GoogleFonts.poppins(
                                   fontSize: 10,
                                   color: Colors.white.withOpacity(0.9),
                                 ),
                               ),
                             ],
                           ),
                           // Status Icons (or something else)

                         ],
                       ),

                       const SizedBox(height: 20),

                       // Profile Card (Floating Style)
                       Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                             Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Avatar
                              Stack(
                                children: [
                                  const CircleAvatar(
                                    radius: 36,
                                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'), // Woman avatar
                                    backgroundColor: Colors.grey,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF4CAF50),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     const SizedBox(height: 8),
                                      Text(
                                          "Sahil Sharma",
                                          style: GoogleFonts.barlowCondensed(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF2C3E50),
                                          ),
                                        ),
                                      Text(
                                          "Delivery Partner",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1, color: Color(0xFFEEEEEE)),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem("150", "Deliveries"),
                              _buildVerticalDivider(),
                              _buildStatItem("\$789", "Ratings"), // Changed label to something else or keep Earnings
                              _buildVerticalDivider(),
                              _buildStatItem("4.8", "Rating"), // Changed to Rating for variety or keep Experience
                            ],
                          )
                          ],
                        ),
                       ),
                       const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        // Personal Information
                        Text(
                          "Personal Information",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2C3E50),
                          ),
                        ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          _buildInfoTile(Icons.phone_outlined, "Phone Number", "+1 (555) 123-4567"),
                          _buildInfoTile(Icons.email_outlined, "Email Address", "xyz.islam@email.com"),
                          _buildInfoTile(Icons.location_on_outlined, "Address", "123 Main St, San Francisco"),
                          _buildInfoTile(
                            Icons.two_wheeler, 
                            "Vehicle & License Details", 
                            "View Details",
                            showArrow: true,
                            onTap: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => const VehicleDetailsScreen())
                              );
                            }
                          ),
                        ],
                      ),

                       const SizedBox(height: 30),

                      // Account Settings
                      Text(
                        "Account Settings",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                           color: const Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          _buildSettingsCard(Icons.credit_card, "Payment Methods", Colors.blue),
                          _buildSettingsCard(Icons.shield_outlined, "Privacy & Security", Colors.orange),
                          _buildSettingsCard(Icons.notifications_outlined, "Notifications", Colors.green),
                          _buildSettingsCard(Icons.logout, "Logout", Colors.red, isDestructive: true),
                        ],
                      ),
                      const SizedBox(height: 100), // Increased to avoid overlap with nav bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Back Button Removed for persistent nav
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.barlowCondensed(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
           style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[200],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle, {VoidCallback? onTap, bool showArrow = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: title.contains("Phone") 
                  ? const Color(0xFFE3F2FD) // Blue tint
                  : (title.contains("Email") 
                      ? const Color(0xFFE8F5E9) // Green tint
                      : (title.contains("Address") ? const Color(0xFFFFF3E0) : const Color(0xFFF3E5F5))), // Orange or Purple tint
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon, 
              color: title.contains("Phone") 
                  ? Colors.blue 
                  : (title.contains("Email") ? Colors.green : (title.contains("Address") ? Colors.orange : Colors.purple)), 
              size: 20
            ),
          ),
          title: Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
          subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
          trailing: showArrow ? const Icon(Icons.chevron_right, color: Colors.grey, size: 20) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(IconData icon, String title, Color color, {bool isDestructive = false}) {
    return GestureDetector(
      onTap: () {
        if (title == "Notifications") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsScreen()),
          );
        } else if (title == "Payment Methods") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentMethodsScreen()),
          );
        } else if (title == "Privacy & Security") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PrivacySecurityScreen()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? Colors.red : const Color(0xFF2C3E50),
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }
}
