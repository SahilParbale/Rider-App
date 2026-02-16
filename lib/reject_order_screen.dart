import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class RejectOrderScreen extends StatefulWidget {
  const RejectOrderScreen({super.key});

  @override
  State<RejectOrderScreen> createState() => _RejectOrderScreenState();
}

class _RejectOrderScreenState extends State<RejectOrderScreen> {
  String? _selectedReason;
  String? _selectedSubReason;
  bool _pauseRequests = false;
  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _reasons = [
    {
      "category": "Earnings Related",
      "options": [
        {"id": "low_earnings", "label": "Low earnings for distance"},
        {"id": "too_far", "label": "Too far from current location"},
        {"id": "no_tip", "label": "No tip visible"},
      ]
    },
    {
      "category": "Personal / Vehicle",
      "options": [
        {"id": "vehicle_issue", "label": "Vehicle issue", "hasSubOptions": true, "subOptions": ["Flat tyre", "Engine issue", "Minor breakdown"]},
        {"id": "personal_break", "label": "Taking a break / End of shift"},
      ]
    },
    {
      "category": "Operational",
      "options": [
        {"id": "traffic", "label": "Traffic issue"},
        {"id": "pickup_difficult", "label": "Pickup location difficult"},
        {"id": "safety", "label": "Safety concern", "hasSubOptions": true, "subOptions": ["Area feels unsafe", "Night time issue", "Past bad experience"]},
      ]
    },
  ];


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 360, maxHeight: 520), // Match OrderRequestScreen height approx
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 30,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   // 1. Header
                  _buildHeader(),
                  const Divider(height: 1, color: AppColors.stroke),
                  
                  Flexible( 
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Reduced vertical padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min, 
                        children: [
                          // 2. Order Summary Card
                          _buildOrderSummaryCard(),
                          const SizedBox(height: 16), // Reduced
                          
                          // 3. Select Reason
                          Text(
                            "Select a reason",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 8), // Reduced
                          ..._buildReasonList(),
                          
                          const SizedBox(height: 12), // Reduced
                          
                          // 5. Optional Toggle
                          _buildPauseToggle(),
                        ],
                      ),
                    ),
                  ),
                  
                  const Divider(height: 1, color: AppColors.stroke),

                  // 6. Submit Button Section
                  _buildBottomBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFFF9FAFB), 
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryText, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reject Order",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.error, // Red for Title
                  ),
                ),
                Text(
                  "Help us understand why",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6), 
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Icon(Icons.storefront, size: 16, color: AppColors.primaryGreen),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fresh Mart",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.primaryText,
                  ),
                ),
                Text(
                  "₹85 • 5.2 km • 22 mins",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildReasonList() {
    List<Widget> widgets = [];
    
    for (var group in _reasons) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 4, top: 2), // Reduced
          child: Text(
            group['category'],
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryText,
              letterSpacing: 0.5,
            ),
          ),
        ),
      );
      
      for (var option in (group['options'] as List)) {
        bool isSelected = _selectedReason == option['label'];
        bool hasSubOptions = option['hasSubOptions'] == true;
        
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedReason = option['label'];
                      _selectedSubReason = null; 
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), // Reduced vertical padding
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.errorLight : Colors.white, // Red light bg
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.error : AppColors.stroke, // Red border
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option['label'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected ? AppColors.error : AppColors.primaryText, // Red text
                            ),
                          ),
                        ),
                         if (isSelected)
                           const Icon(Icons.check_circle, size: 18, color: AppColors.error) // Red icon
                         else
                           Icon(Icons.radio_button_unchecked, size: 18, color: Colors.grey.shade400),
                      ],
                    ),
                  ),
                ),
                
                // Sub-options Logic
                if (isSelected && hasSubOptions)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (option['subOptions'] as List<String>).map((subOption) {
                        bool isSubSelected = _selectedSubReason == subOption;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedSubReason = subOption;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSubSelected ? AppColors.errorLight.withOpacity(0.5) : AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSubSelected ? AppColors.error.withOpacity(0.5) : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSubSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  size: 14,
                                  color: isSubSelected ? AppColors.error : AppColors.secondaryText, // Red icon
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  subOption,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: isSubSelected ? AppColors.primaryText : AppColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    }
    return widgets;
  }

  Widget _buildPauseToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _pauseRequests = !_pauseRequests;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
         decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(
                value: _pauseRequests,
                onChanged: (val) {
                  setState(() {
                    _pauseRequests = val ?? false;
                  });
                },
                activeColor: AppColors.error, // Red checkbox
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                side: BorderSide(color: AppColors.secondaryText, width: 1.5),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Pause new orders (15m)",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    bool isEnabled = _selectedReason != null;
    
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: (isEnabled && !_isSubmitting) ? _submitRejection : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error, // Red button
                disabledBackgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: isEnabled ? 2 : 0,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(
                      "Submit Reason",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitRejection() async {
    setState(() {
      _isSubmitting = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      // Logic: Order Rejected.
      // Navigator.pop(context) returns to home since we used pushReplacement.
      Navigator.pop(context); 
    }
  }
}
