import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AddUpiScreen extends StatefulWidget {
  final bool isEdit;
  final String? initialUpiId;
  final String? initialProvider;

  const AddUpiScreen({
    super.key,
    this.isEdit = false,
    this.initialUpiId,
    this.initialProvider,
  });

  @override
  State<AddUpiScreen> createState() => _AddUpiScreenState();
}

class _AddUpiScreenState extends State<AddUpiScreen> {
  late TextEditingController _upiController;
  late String _selectedProvider;
  bool _isDefault = false;

  final List<Map<String, dynamic>> _providers = [
    {"name": "Google Pay", "handle": "@okaxis, @oksbi", "icon": Icons.account_balance_wallet_outlined},
    {"name": "PhonePe", "handle": "@ybl, @ibl", "icon": Icons.phonelink_ring_outlined},
    {"name": "Paytm", "handle": "@paytm", "icon": Icons.payment_outlined},
  ];

  @override
  void initState() {
    super.initState();
    _upiController = TextEditingController(text: widget.initialUpiId ?? "");
    _selectedProvider = widget.initialProvider ?? "Google Pay";
  }

  @override
  void dispose() {
    _upiController.dispose();
    super.dispose();
  }

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
                        widget.isEdit ? "Edit UPI ID" : "Add UPI ID",
                        style: GoogleFonts.barlowCondensed(
                          fontSize: 28, // Reduced from 32
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Fixed Preview Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildPreviewCard(),
                ),

                const SizedBox(height: 20),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        
                        Text(
                          "Select UPI Provider",
                          style: GoogleFonts.poppins(
                            fontSize: 16, // Reduced from 18
                            fontWeight: FontWeight.w700,
                            color: Colors.black, // Color to black
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _providers.map((p) => _buildProviderOption(p)).toList(),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        Text(
                          "Enter UPI ID",
                          style: GoogleFonts.poppins(
                            fontSize: 16, // Reduced from 18
                            fontWeight: FontWeight.w700,
                            color: Colors.black, // Color to black
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                                  color: AppColors.primaryGreen, // Changed from Dark Navy
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.alternate_email, color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextField(
                                  controller: _upiController,
                                  onChanged: (val) => setState(() {}),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "yourname@bank",
                                    hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16, // Reduced from 18
                                    color: Colors.black, // Color to black
                                  ),
                                ),
                              ),
                              if (_upiController.text.contains("@"))
                                const Icon(Icons.check_circle, color: AppColors.primaryGreen, size: 24),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Default Switch
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8FAFC),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.star, color: Color(0xFFF59E0B), size: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Set as Default",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14, // Reduced from 15
                                        color: Colors.black, // Color to black
                                      ),
                                    ),
                                    Text(
                                      "Use as my default UPI payment",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11, // Reduced from 12
                                        color: Colors.black54, // Color towards black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _isDefault,
                                onChanged: (val) => setState(() => _isDefault = val),
                                activeColor: AppColors.primaryGreen,
                                activeTrackColor: AppColors.primaryGreen.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 60),
                        
                        // Action Button
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen, // Changed from Dark Navy
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryGreen.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                widget.isEdit ? "Update UPI ID" : "Save UPI ID",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16, // Reduced from 18
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.account_balance_wallet_outlined, size: 28, color: Color(0xFF64748B)),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PROVIDER",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    _selectedProvider,
                    style: GoogleFonts.poppins(
                      fontSize: 18, // Reduced from 20
                      fontWeight: FontWeight.w700,
                      color: Colors.black, // Color to black
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            "UPI ID",
            style: GoogleFonts.poppins(
              fontSize: 9, // Reduced from 10
              fontWeight: FontWeight.w700,
              color: Colors.grey[400],
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _upiController.text.isEmpty ? "yourname@bank" : _upiController.text,
            style: GoogleFonts.poppins(
              fontSize: 20, // Reduced from 24
              fontWeight: FontWeight.w500, // Reduced weight from w700
              color: _upiController.text.isEmpty ? Colors.grey[200] : Colors.black, // Color to black
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderOption(Map<String, dynamic> provider) {
    bool isSelected = _selectedProvider == provider["name"];
    return GestureDetector(
      onTap: () => setState(() => _selectedProvider = provider["name"]),
      child: Container(
        width: (MediaQuery.of(context).size.width - 32 - 32) / 3,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : Colors.white, // Changed from Dark Navy
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGreen.withOpacity(isSelected ? 0.2 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.1) : const Color(0xFFF8FAFC),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSelected ? Icons.check_circle : provider["icon"],
                color: isSelected ? Colors.white : AppColors.primaryGreen,
                size: 20, // Reduced from 22
              ),
            ),
            const SizedBox(height: 14),
            Text(
              provider["name"],
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 13, // Reduced from 14
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : Colors.black, // Color to black
              ),
            ),
            const SizedBox(height: 4),
            Text(
              provider["handle"],
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 8, // Reduced from 9
                color: isSelected ? Colors.white60 : Colors.black54, // Color towards black
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
