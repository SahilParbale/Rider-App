import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'privacy_policy_screen.dart';
import 'manage_permissions_screen.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                // Header Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                            "Back",
                            style: GoogleFonts.barlowCondensed(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF23AA49),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Privacy & Security",
                        style: GoogleFonts.barlowCondensed(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Main Content
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 10),
                      _buildSecuritySection(
                        title: "Privacy Policy",
                        icon: Icons.privacy_tip_outlined,
                        color: Colors.blue,
                        content: "We value your privacy. Our policy outlines how we collect, use, and protect your information to provide a better delivery experience.",
                        actionText: "Read Full Policy",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
                          );
                        }
                      ),
                      
                      _buildSecuritySection(
                        title: "Data Protection",
                        icon: Icons.security_outlined,
                        color: Colors.green,
                        content: "Your personal and financial data is encrypted using industry-standard protocols. We never share your sensitive info with third parties without your consent.",
                      ),

                      _buildSecuritySection(
                        title: "App Permissions",
                        icon: Icons.toggle_on_outlined,
                        color: Colors.orange,
                        content: "Control over your data. You can manage permissions like Location, Camera, and Notifications at any time through your device settings.",
                        actionText: "Manage Permissions",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ManagePermissionsScreen()),
                          );
                        }
                      ),

                      _buildSecuritySection(
                        title: "Account Security",
                        icon: Icons.lock_outline,
                        color: Colors.purple,
                        content: "Keep your account safe. We recommend using a strong password and enabling biometric login if supported by your device.",
                        actionText: "Change Password",
                      ),

                      _buildSecuritySection(
                        title: "Security Updates",
                        icon: Icons.system_update_alt_outlined,
                        color: Colors.teal,
                        content: "We regularly update our systems to guard against new threats. Ensure your app is always up to date for the latest security patches.",
                      ),

                      const SizedBox(height: 40),
                      
                      Center(
                        child: Column(
                          children: [
                            const Icon(Icons.verified_user_outlined, color: AppColors.primaryGreen, size: 48),
                            const SizedBox(height: 12),
                            Text(
                              "Your privacy is our priority",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Version 1.0.4 - Secure",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection({
    required String title,
    required IconData icon,
    required Color color,
    required String content,
    String? actionText,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),
                if (actionText != null) ...[
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: onTap ?? () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            actionText,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.primaryGreen),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
