import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'add_upi_screen.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  // Dummy data for demonstration
  String _defaultUpiId = "sarah@oksbi";
  String _defaultProvider = "Google Pay";
  
  final List<Map<String, String>> _savedUpiIds = [
    {"id": "sarah.johnson@ybl", "provider": "PhonePe"},
  ];

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
                        "UPI Payment",
                        style: GoogleFonts.barlowCondensed(
                          fontSize: 28, // Reduced from 32
                          fontWeight: FontWeight.w700,
                          color: Colors.white, // Keeping white for header on green background
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Fixed Default UPI Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildPaymentMethodCard(
                    provider: _defaultProvider,
                    upiId: _defaultUpiId,
                    isDefault: true,
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddUpiScreen(
                            isEdit: true,
                            initialUpiId: _defaultUpiId,
                            initialProvider: _defaultProvider,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Scrollable Content
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const SizedBox(height: 10), // Small top padding for scroll content
                      
                      ..._savedUpiIds.map((upi) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildPaymentMethodCard(
                          provider: upi["provider"]!,
                          upiId: upi["id"]!,
                          isDefault: false,
                          onEdit: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddUpiScreen(
                                  isEdit: true,
                                  initialUpiId: upi["id"]!,
                                  initialProvider: upi["provider"]!,
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                      
                      const SizedBox(height: 20),
                      
                      // Secure Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF2FBF5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.security, color: AppColors.primaryGreen, size: 24),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "UPI Payments are Secure",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13, // Reduced from 14
                                      color: Colors.black, // Color to black
                                    ),
                                  ),
                                  Text(
                                    "All UPI transactions are encrypted and processed through secure payment gateways",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9, // Reduced from 10
                                      color: Colors.black54, // Color towards black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 120), // Space for button
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Add Button
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddUpiScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGreen.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add New UPI ID",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15, // Reduced from 16
                          ),
                        ),
                        Text(
                          "Link your UPI account",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 11, // Reduced from 12
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18, // Reduced from 20
          fontWeight: FontWeight.w700,
          color: Colors.black, // Color to black
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required String provider,
    required String upiId,
    required bool isDefault,
    required VoidCallback onEdit,
  }) {
    return Container(
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.account_balance_wallet_outlined, size: 24, color: Color(0xFF64748B)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PROVIDER",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[400],
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      provider,
                      style: GoogleFonts.poppins(
                        fontSize: 16, // Reduced from 18
                        fontWeight: FontWeight.w700,
                        color: Colors.black, // Color to black
                      ),
                    ),
                  ],
                ),
              ),
              if (isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check, size: 13, color: AppColors.primaryGreen), // Reduced from 14
                      const SizedBox(width: 4),
                      Text(
                        "Default",
                        style: GoogleFonts.poppins(
                          fontSize: 11, // Reduced from 12
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "UPI ID",
                      style: GoogleFonts.poppins(
                        fontSize: 9, // Reduced from 10
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[400],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      upiId,
                      style: GoogleFonts.poppins(
                        fontSize: 20, // Reduced from 22
                        fontWeight: FontWeight.w500, // Reduced weight from w700
                        color: Colors.black, // Color to black
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, size: 13, color: AppColors.primaryGreen), // Reduced from 14
                    const SizedBox(width: 4),
                    Text(
                      "Verified",
                      style: GoogleFonts.poppins(
                        fontSize: 11, // Reduced from 12
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF475569)),
                        const SizedBox(width: 8),
                        Text(
                          "Edit",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!isDefault) ...[
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                         // Swap logic for dummy
                         String tempId = _defaultUpiId;
                         String tempProv = _defaultProvider;
                         _defaultUpiId = upiId;
                         _defaultProvider = provider;
                         _savedUpiIds.removeWhere((element) => element["id"] == upiId);
                         _savedUpiIds.add({"id": tempId, "provider": tempProv});
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Set Default",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                   setState(() {
                      if (!isDefault) {
                        _savedUpiIds.removeWhere((element) => element["id"] == upiId);
                      }
                   });
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
