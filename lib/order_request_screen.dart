import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'reject_order_screen.dart';

class OrderRequestScreen extends StatefulWidget {
  final VoidCallback? onAccept;
  const OrderRequestScreen({super.key, this.onAccept});

  @override
  State<OrderRequestScreen> createState() => _OrderRequestScreenState();
}

class _OrderRequestScreenState extends State<OrderRequestScreen> with SingleTickerProviderStateMixin {
  int _secondsRemaining = 30;
  Timer? _timer;
  double _sliderValue = 0.0;
  bool _isAccepted = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    startTimer();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(_pulseController);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        // Handle timeout (auto-decline)
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6), // Glass effect background dim
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ScaleTransition(
            scale: const AlwaysStoppedAnimation(1.0),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 360), // Slightly narrower for better fit
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
                    // 1. Header Section
                    _buildHeader(),
                    
                    const Divider(height: 1),
                    
                    // Main Content - Compact but Spacious
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), // Increased padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 2. Earnings & Trip Summary
                          _buildEarningsSection(),
                          const SizedBox(height: 24), // Increased spacing
                          
                          // 3. Pickup & Drop Details
                          _buildRouteDetails(),
                          const SizedBox(height: 24), // Increased spacing
                          
                          // 4. Order Details
                          _buildOrderDetails(),
                        ],
                      ),
                    ),
                    
                    const Divider(height: 1),
                    
                    // 5. Slider Section
                    _buildSliderSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    bool isUrgent = _secondsRemaining < 10;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: isUrgent ? AppColors.errorLight : const Color(0xFFF0FDF4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Request",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              Text(
                "Order #12345",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          ScaleTransition(
            scale: isUrgent ? _pulseAnimation : const AlwaysStoppedAnimation(1.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isUrgent ? AppColors.error : AppColors.success,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: (isUrgent ? AppColors.error : AppColors.success).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer_outlined, color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsSection() {
    return Row(
      children: [
        // Left: Earnings
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ESTIMATED EARNINGS",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryText,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "₹85",
                      style: GoogleFonts.barlowCondensed(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    TextSpan(
                      text: ".00",
                      style: GoogleFonts.barlowCondensed(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildMiniTag("Base ₹50"),
                  const SizedBox(width: 4),
                  _buildMiniTag("Dist ₹20", isBonus: true),
                  const SizedBox(width: 4),
                  _buildMiniTag("Tip ₹5"),
                ],
              ),
            ],
          ),
        ),
        // Vertical Divider Removed
        // Container(width: 1, height: 50, color: AppColors.stroke, margin: const EdgeInsets.symmetric(horizontal: 24)), 
        const SizedBox(width: 16),
        // Right: Trip Summary
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // Align to right
            children: [
              _buildTripStat(Icons.directions_bike, "5.2 km", "Total Distance"),
              const SizedBox(height: 8),
              _buildTripStat(Icons.schedule, "25 min", "Est. Time"),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildMiniTag(String text, {bool isBonus = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isBonus ? const Color(0xFFFFF3E0) : AppColors.background,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isBonus ? Colors.orange.withOpacity(0.3) : Colors.transparent),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: isBonus ? Colors.orange[800] : AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildTripStat(IconData icon, String value, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align row content to right
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Align text to right
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12, // Reduced font size
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
             Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 9, // Reduced font size
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
        const SizedBox(width: 6),
        Icon(icon, size: 14, color: AppColors.primaryText),
      ],
    );
  }

  Widget _buildRouteDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Pickup
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 4),
                    const Icon(Icons.storefront, size: 16, color: AppColors.primaryGreen),
                    Container(
                      height: 30,
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primaryGreen, AppColors.primaryGreen.withOpacity(0.1)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PICKUP",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryGreen,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Burger King",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            "1.2 km",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.primaryText),
                          ),
                        ],
                      ),
                      Text(
                        "Shop 12, GIP Mall, Sector 18, Noida, Uttar Pradesh 201301",
                        style: GoogleFonts.poppins(fontSize: 13, color: AppColors.secondaryText, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Divider(height: 1, color: AppColors.stroke),
          
          // Drop
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 16, color: AppColors.error),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "DROP",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.error,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sahil Sharma",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          Text(
                            "3.5 km",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.primaryText),
                          ),
                        ],
                      ),
                      Text(
                        "B-45, Sector 62, Noida, Uttar Pradesh 201309 (Near Metro Station)",
                        style: GoogleFonts.poppins(fontSize: 13, color: AppColors.secondaryText, height: 1.4),
                      ),
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

  Widget _buildOrderDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailChip(Icons.shopping_bag_outlined, "3 Items", Colors.blue.shade50, Colors.blue.shade700),
        _buildDetailChip(Icons.credit_card, "Prepaid", Colors.purple.shade50, Colors.purple.shade700),
        _buildDetailChip(Icons.scale, "2.5 kg", Colors.orange.shade50, Colors.orange.shade800),
      ],
    );
  }

  Widget _buildDetailChip(IconData icon, String label, Color bg, Color textData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textData),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textData,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Slider
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // Background Track
                  Container(
                    height: 56, // Slightly taller
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F4F9),
                      borderRadius: BorderRadius.circular(28),
                      // border: Border.all(color: Colors.grey.shade300), // Removed border for cleaner look
                      boxShadow: [
                         BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: _isAccepted 
                      ? Text(
                          "ACCEPTED!",
                          style: GoogleFonts.poppins(
                            color: AppColors.primaryGreen,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        )
                      : Opacity(
                          opacity: (1 - _sliderValue).clamp(0.0, 1.0), // Fade out text
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Swipe to Accept",
                                style: GoogleFonts.poppins(
                                  color: AppColors.secondaryText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                               const SizedBox(width: 8),
                              Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.secondaryText.withOpacity(0.5)),
                               Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.secondaryText.withOpacity(0.3)),
                            ],
                          ),
                        ),
                  ),
                  
                  // Active Track (Gradient)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: 56,
                    width: 56 + (_sliderValue * (constraints.maxWidth - 56)),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isAccepted 
                            ? [AppColors.success, AppColors.success] // Solid success color when done
                            : [AppColors.headerGreen, AppColors.primaryGreen],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: _isAccepted ? [
                        BoxShadow(
                          color: AppColors.success.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ] : [],
                    ),
                    alignment: Alignment.center,
                     child: _isAccepted 
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Redirecting...",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )
                        : null,
                  ),

                  // Knob (Only visible if not accepted)
                  if (!_isAccepted)
                  Positioned(
                    left: _sliderValue * (constraints.maxWidth - 56),
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _sliderValue += details.primaryDelta! / (constraints.maxWidth - 56);
                          _sliderValue = _sliderValue.clamp(0.0, 1.0);
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        if (_sliderValue > 0.85) { // Higher threshold
                           setState(() {
                             _sliderValue = 1.0;
                             _isAccepted = true;
                           });
                           // Perform accept action
                           Future.delayed(const Duration(seconds: 1), () { // Longer delay to see success
                             if (mounted) {
                               widget.onAccept?.call(); // Navigate to Rider Page
                               Navigator.pop(context); 
                             }
                           });
                        } else {
                          setState(() {
                            _sliderValue = 0.0;
                          });
                        }
                      },
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.primaryGreen,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
          const SizedBox(height: 16),
          // Decline Button
          GestureDetector(
              onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RejectOrderScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Decline Order",
                  style: GoogleFonts.poppins(
                    color: AppColors.error,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
