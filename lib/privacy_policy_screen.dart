import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                        "Privacy Policy",
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
                        // Content Container
                        Container(
                            padding: const EdgeInsets.all(24),
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
                                    _buildSectionTitle("1. Data Collection"),
                                    _buildSectionContent("We collect information to provide better services to all our users. This includes basic stuff like your name, device info and contact details, to more complex things like which delivery routes you take and real-time location. The information Delivery Partner App collects, and how that information is used, depends on how you use our services and how you manage your privacy controls."),
                                    const SizedBox(height: 20),
                                    
                                    _buildSectionTitle("2. How We Use Your Data"),
                                    _buildSectionContent("Your data is used solely to improve your delivery experience, verify your identity, process payments securely, and ensure you receive the correct orders efficiently. We also use your information to ensure our services are working as intended, such as tracking outages or troubleshooting issues that you report to us."),
                                    const SizedBox(height: 20),

                                    _buildSectionTitle("3. Information Sharing"),
                                    _buildSectionContent("We do not share your personal information with companies, organizations, or individuals outside of our company unless you have explicitly provided us with your consent, or for legal reasons. We may share information with domain administrators if your account is managed by them."),
                                    const SizedBox(height: 20),

                                    _buildSectionTitle("4. Data Security"),
                                    _buildSectionContent("We work hard to protect you from unauthorized access, alteration, disclosure, or destruction of information we hold. We use encryption to keep your data private while in transit. We review our information collection, storage, and processing practices, including physical security measures, to prevent unauthorized access to our systems."),
                                    const SizedBox(height: 20),

                                    _buildSectionTitle("5. Your Rights"),
                                    _buildSectionContent("You have the right to request access to the personal data we hold about you, request corrections, or request deletion of your data when it is no longer necessary for the purposes it was collected. You can manage your preferences directly in the app settings."),
                                    const SizedBox(height: 10),
                                ]
                            )
                        ),
                        const SizedBox(height: 40),
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

  Widget _buildSectionTitle(String title) {
      return Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2C3E50),
          )
      );
  }

  Widget _buildSectionContent(String content) {
      return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
              content,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.6,
              )
          ),
      );
  }
}
