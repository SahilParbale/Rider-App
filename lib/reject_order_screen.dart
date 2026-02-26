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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Red Header Background 
          Positioned(
            top: 0,
            left: -5,
            right: -5,
            child: Container(
              height: 220, 
              decoration: const BoxDecoration(
                color: Color(0xFFF90F24), // Red color
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                  child: Column(
                    children: [
                      // Header Row
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           // Back Button
                           GestureDetector(
                             onTap: () => Navigator.pop(context),
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                               decoration: BoxDecoration(
                                 color: const Color(0xFFFEF2F2), // Light Red background
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
                                   color: const Color(0xFFF90F24), // Red Text
                                 ),
                               ),
                             ),
                           ),
                           
                           // Title
                           Flexible(
                             child: Text(
                               "Reason for order rejecting",
                               textAlign: TextAlign.right,
                               style: GoogleFonts.barlowCondensed(
                                 fontSize: 26,
                                 fontWeight: FontWeight.w700,
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 24),

                       // Order Summary Card
                       _buildOrderSummaryCard(),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),

                // Main Content (Reasons)
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 8),
                                child: Text(
                                  "Help us understand why",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      ..._buildReasonList(),
                                      const SizedBox(height: 16),
                                      _buildPauseToggle(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Bottom Bar
                        const Divider(height: 1, color: AppColors.stroke),
                        _buildBottomBar(),
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

  Widget _buildOrderSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
              color: const Color(0xFFF3F4F6),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Icon(Icons.storefront, size: 24, color: AppColors.primaryGreen),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fresh Mart",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primaryText,
                  ),
                ),
                Text(
                  "₹85 • 5.2 km • 22 mins",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
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

  IconData _getIconForReason(String id) {
    switch (id) {
      case 'low_earnings': return Icons.account_balance_wallet_outlined;
      case 'too_far': return Icons.directions_bike_outlined;
      case 'no_tip': return Icons.money_off_csred_outlined;
      case 'vehicle_issue': return Icons.two_wheeler;
      case 'personal_break': return Icons.coffee_outlined;
      case 'traffic': return Icons.traffic_outlined;
      case 'pickup_difficult': return Icons.storefront_outlined;
      case 'safety': return Icons.health_and_safety_outlined;
      default: return Icons.radio_button_unchecked;
    }
  }

  List<Widget> _buildReasonList() {
    List<Widget> widgets = [];
    
    for (var group in _reasons) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 16),
          child: Text(
            group['category'].toString().toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryText,
              letterSpacing: 1.2,
            ),
          ),
        ),
      );
      
      for (var option in (group['options'] as List)) {
        bool isSelected = _selectedReason == option['label'];
        bool hasSubOptions = option['hasSubOptions'] == true;
        
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedReason = option['label'];
                      _selectedSubReason = null; 
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.errorLight : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppColors.error : Colors.grey.shade200,
                        width: isSelected ? 1.5 : 1,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: AppColors.errorLight.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ] : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.error.withOpacity(0.1) : const Color(0xFFF5F7FA),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getIconForReason(option['id']), 
                            size: 20, 
                            color: isSelected ? AppColors.error : AppColors.secondaryText
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            option['label'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? AppColors.primaryText : Colors.black87,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.radio_button_checked, size: 22, color: AppColors.error)
                        else
                          Icon(Icons.radio_button_unchecked, size: 22, color: Colors.grey.shade300),
                      ],
                    ),
                  ),
                ),
                
                // Sub-options Logic
                if (isSelected && hasSubOptions)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: (option['subOptions'] as List<String>).map((subOption) {
                        bool isSubSelected = _selectedSubReason == subOption;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSubReason = subOption;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSubSelected ? AppColors.errorLight.withOpacity(0.7) : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSubSelected ? AppColors.error.withOpacity(0.5) : Colors.grey.shade200,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSubSelected ? Icons.check_circle : Icons.circle_outlined,
                                  size: 16,
                                  color: isSubSelected ? AppColors.error : Colors.grey.shade400,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  subOption,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: isSubSelected ? FontWeight.w600 : FontWeight.w500,
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
