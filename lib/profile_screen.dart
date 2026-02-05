import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          // Green Header
          Container(
            height: 300,
            color: const Color(0xFF4CAF50),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 0), // Full width for list items
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Profile",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        // Status Icons (Simulated)
                        Row(
                          children: [
                            Icon(Icons.signal_cellular_alt, color: Colors.white.withOpacity(0.8), size: 18),
                            const SizedBox(width: 8),
                            Icon(Icons.wifi, color: Colors.white.withOpacity(0.8), size: 18),
                            const SizedBox(width: 8),
                            Icon(Icons.battery_full, color: Colors.white.withOpacity(0.8), size: 18),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Profile Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
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
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Xyz Islam",
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.edit, size: 16, color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Delivery Partner",
                                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.orange, size: 18),
                                        const SizedBox(width: 4),
                                        Text(
                                          "4.8",
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "(245 reviews)",
                                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem("150", "Deliveries"),
                              _buildVerticalDivider(),
                              _buildStatItem("\$789", "Earnings"),
                              _buildVerticalDivider(),
                              _buildStatItem("2.5y", "Experience"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Personal Information
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Personal Information",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildInfoTile(Icons.phone_outlined, "Phone Number", "+1 (555) 123-4567"),
                        _buildDivider(),
                        _buildInfoTile(Icons.email_outlined, "Email Address", "xyz.islam@email.com"),
                        _buildDivider(),
                        _buildInfoTile(Icons.location_on_outlined, "Address", "123 Main St, San Francisco"),
                      ],
                    ),
                  ),

                   const SizedBox(height: 30),

                  // Account Settings
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Account Settings",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                         color: const Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildSettingsTile(Icons.credit_card, "Payment Methods", Colors.blue),
                        _buildDivider(),
                        _buildSettingsTile(Icons.shield_outlined, "Privacy & Security", Colors.orange),
                        _buildDivider(),
                        _buildSettingsTile(Icons.notifications_outlined, "Notifications", Colors.green),
                        _buildDivider(),
                         _buildSettingsTile(Icons.logout, "Logout", Colors.red, isDestructive: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Bottom Nav Placeholder to push content up if needed
                  // Or rely on global nav
                ],
              ),
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
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
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

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[100], indent: 60, endIndent: 20);
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05), // Using Blueish tint per design image roughly
          borderRadius: BorderRadius.circular(12),
        ),
        // Colors specific to design:
        // Phone: Blue
        // Email: Green
        // Address: Orange
        child: Icon(
          icon, 
          color: title.contains("Phone") ? Colors.blue : (title.contains("Email") ? Colors.green : Colors.orange), 
          size: 22
        ),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, Color color, {bool isDestructive = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), 
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title, 
        style: GoogleFonts.poppins(
          fontSize: 14, 
          fontWeight: FontWeight.w500, 
          color: isDestructive ? Colors.red : Colors.black87
        )
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: () {},
    );
  }
}
