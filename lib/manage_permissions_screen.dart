import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class ManagePermissionsScreen extends StatefulWidget {
  const ManagePermissionsScreen({super.key});

  @override
  State<ManagePermissionsScreen> createState() => _ManagePermissionsScreenState();
}

class _ManagePermissionsScreenState extends State<ManagePermissionsScreen> {
  // Mock permission states
  bool _locationEnabled = true;
  bool _cameraEnabled = false;
  bool _notificationsEnabled = true;
  bool _contactsEnabled = false;
  bool _storageEnabled = true;

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
                        "Permissions",
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
                      
                      _buildPermissionToggle(
                        title: "Location Access",
                        subtitle: "Required for finding delivery routes and tracking orders.",
                        icon: Icons.location_on_outlined,
                        color: Colors.blue,
                        value: _locationEnabled,
                        onChanged: (val) => setState(() => _locationEnabled = val),
                      ),
                      
                      _buildPermissionToggle(
                        title: "Camera",
                        subtitle: "Used for scanning QR codes and taking proofs of delivery.",
                        icon: Icons.camera_alt_outlined,
                        color: Colors.orange,
                        value: _cameraEnabled,
                        onChanged: (val) => setState(() => _cameraEnabled = val),
                      ),

                      _buildPermissionToggle(
                        title: "Push Notifications",
                        subtitle: "Receive alerts for incoming orders and status updates.",
                        icon: Icons.notifications_none_outlined,
                        color: Colors.redAccent,
                        value: _notificationsEnabled,
                        onChanged: (val) => setState(() => _notificationsEnabled = val),
                      ),

                      _buildPermissionToggle(
                         title: "Contacts",
                         subtitle: "Allows easy sharing of referral links with friends.",
                         icon: Icons.contacts_outlined,
                         color: Colors.green,
                         value: _contactsEnabled,
                         onChanged: (val) => setState(() => _contactsEnabled = val),
                      ),

                      _buildPermissionToggle(
                         title: "Storage & Media",
                         subtitle: "Save and upload profile pictures and receipts.",
                         icon: Icons.folder_open_outlined,
                         color: Colors.purple,
                         value: _storageEnabled,
                         onChanged: (val) => setState(() => _storageEnabled = val),
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

  Widget _buildPermissionToggle({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
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
                     fontWeight: FontWeight.w700,
                     color: const Color(0xFF2C3E50),
                   ),
                 ),
                 const SizedBox(height: 4),
                 Text(
                   subtitle,
                   style: GoogleFonts.poppins(
                     fontSize: 12,
                     color: Colors.black54,
                     height: 1.4,
                   ),
                 ),
               ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primaryGreen,
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
