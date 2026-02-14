import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();
  int _selectedAmount = 0;
  WithdrawalMethod? _selectedMethod; // Deprecated, keeping for safety but not used
  // ignore: unused_field
  String _withdrawType = "Pay App"; // Default selection
  
  final List<WithdrawalMethod> _methods = [
    WithdrawalMethod(id: "1", name: "Google Pay", subtitle: "sarah@oksbi", icon: Icons.account_balance_wallet, color: Colors.blue),
    WithdrawalMethod(id: "2", name: "PhonePe", subtitle: "sarah.johnson@ybl", icon: Icons.phonelink_ring, color: Colors.purple),
    WithdrawalMethod(id: "3", name: "Paytm", subtitle: "9876543210@paytm", icon: Icons.payment, color: Colors.indigo),
  ];

  final List<WithdrawalMethod> _upiMethods = [
    WithdrawalMethod(id: "1", name: "Sarah UPI", subtitle: "sarah@upi", icon: Icons.alternate_email, color: Colors.orange),
    WithdrawalMethod(id: "2", name: "Work UPI", subtitle: "sarah.work@okicici", icon: Icons.work, color: Colors.blueGrey),
  ];

  final List<WithdrawalMethod> _bankMethods = [
    WithdrawalMethod(id: "1", name: "Bank of America", subtitle: "**** 4532", icon: Icons.account_balance, color: Colors.red),
    WithdrawalMethod(id: "2", name: "Chase Bank", subtitle: "**** 7821", icon: Icons.local_atm, color: Colors.blue[900]!),
  ];
  
  // Track selection per type
  WithdrawalMethod? _selectedPayApp;
  WithdrawalMethod? _selectedUPI;
  WithdrawalMethod? _selectedBank;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _setAmount(int amount) {
    setState(() {
      _selectedAmount = amount;
      _amountController.text = amount.toString();
    });
  }

  void _showWithdrawalMethodSelector(String title, List<WithdrawalMethod> methods, Function(WithdrawalMethod) onSelect) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    title,
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 10),
            
            // List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  ...methods.map((method) => _buildPaymentAppItem(method, onSelect: onSelect)),
                  
                  const SizedBox(height: 16),
                  

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawTypeCard(String title, IconData icon, String subtitle, bool isSelected) {
      return Expanded(
          child: GestureDetector(
              onTap: () {
                  setState(() {
                      // Map visual titles to logic types if needed, but here we use direct mapping except "COD" in UI -> "Bank" logic maybe? 
                      // User requested "Pay App, UPI, Bank".
                      if (title == "Bank Acc") {
                          _withdrawType = "Bank"; 
                      } else {
                         _withdrawType = title;
                      }
                      
                      if (_withdrawType == "Pay App") {
                          _showWithdrawalMethodSelector("Select Payment App", _methods, (method) {
                              setState(() {
                                  _selectedPayApp = method;
                                  Navigator.pop(context);
                              });
                          });
                      } else if (_withdrawType == "UPI") {
                          _showWithdrawalMethodSelector("Select UPI ID", _upiMethods, (method) {
                              setState(() {
                                  _selectedUPI = method;
                                  Navigator.pop(context);
                              });
                          });
                      } else if (_withdrawType == "Bank") {
                          _showWithdrawalMethodSelector("Select Bank Account", _bankMethods, (method) {
                              setState(() {
                                  _selectedBank = method;
                                  Navigator.pop(context);
                              });
                          });
                      }
                  });
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryGreen : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              blurRadius: 5,
                          ),
                      ],
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: isSelected ? Colors.white.withOpacity(0.2) : Colors.grey[100],
                                  shape: BoxShape.circle,
                              ),
                              child: Icon(icon, color: isSelected ? Colors.white : AppColors.primaryText, size: 20),
                          ),
                          const SizedBox(height: 12),
                          Text(
                              title,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: isSelected ? Colors.white : AppColors.primaryText,
                              ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                              subtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: isSelected ? Colors.white70 : Colors.grey[500],
                              ),
                          ),
                      ],
                  ),
              ),
          )
      );
  }

  Widget _buildTextField(String hint, IconData icon) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 5,
                  ),
              ],
          ),
          child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                  icon: Icon(icon, color: Colors.grey),
              ),
          ),
      );
  }

  Widget _buildPaymentAppItem(WithdrawalMethod method, {bool isSelected = false, Function(WithdrawalMethod)? onSelect}) {
      return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isSelected ? AppColors.primaryGreen : Colors.grey.withOpacity(0.2), width: isSelected ? 1.5 : 1),
              boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                  ),
              ],
          ),
          child: Row(
              children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(method.icon, color: Colors.black87),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                  method.name,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black87,
                                  ),
                              ),
                              Text(
                                  method.subtitle,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                  ),
                              ),
                          ],
                      ),
                  ),
                  if (isSelected)
                      const Icon(Icons.check_circle, color: AppColors.primaryGreen)
                  else
                      ElevatedButton(
                          onPressed: () {
                               onSelect?.call(method);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                          ),
                          child: Text(
                              "Select",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                              ),
                          ),
                      ),
              ],
          ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Green Header (Background only)
          Positioned(
            top: 0,
            left: -5,
            right: -5,
            child: Container(
              height: 180, // Reduced height
              decoration: const BoxDecoration(
                color: AppColors.headerGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),

          // Main Layout
          SafeArea(
            child: Column(
              children: [
                // Fixed Header Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          
                          // Title & Subtitle
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Withdrawl",
                                style: GoogleFonts.barlowCondensed(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Enter the amount you want to withdraw",
                                style: GoogleFonts.poppins(
                                  fontSize: 10, // Slightly smaller to fit
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Available Balance Card (Fixed)
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
                            Text(
                              "Available Balance",
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                             Text(
                              "\$789.00",
                              style: GoogleFonts.barlowCondensed(
                                color: AppColors.primaryGreen,
                                fontSize: 42,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                             Text(
                              "Minimum withdrawal: \$10",
                              style: GoogleFonts.poppins(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      // Enter Amount Label
                      Text(
                        "Enter Amount",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Amount Input
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                           boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2FBF5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.attach_money, color: AppColors.primaryGreen),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0",
                                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedAmount = int.tryParse(val) ?? 0;
                                  });
                                },
                              ),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Icon(Icons.arrow_drop_up, color: Colors.grey[400], size: 20),
                                    Icon(Icons.arrow_drop_down, color: Colors.grey[400], size: 20),
                                ]
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Quick Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [50, 100, 250, 500].map((amount) {
                          return GestureDetector(
                            onTap: () => _setAmount(amount),
                            child: Container(
                              width: (MediaQuery.of(context).size.width - 32 - 36) / 4, // Calculate width: Screen - padding - gap
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: _selectedAmount == amount ? AppColors.primaryGreen : Colors.transparent,
                                    width: 1.5,
                                ),
                                 boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.05),
                                      blurRadius: 5,
                                    ),
                                  ],
                              ),
                              child: Center(
                                child: Text(
                                  "\$$amount",
                                  style: GoogleFonts.barlowCondensed(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Withdraw To
                      Text(
                        "Select Withdrawal Method",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Withdrawal Type Selection Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildWithdrawTypeCard("Pay App", Icons.account_balance_wallet, "Quick payment", _withdrawType == "Pay App"),
                          const SizedBox(width: 12),
                          _buildWithdrawTypeCard("UPI", Icons.payment, "Pay via UPI", _withdrawType == "UPI"),
                          const SizedBox(width: 12),
                          _buildWithdrawTypeCard("Bank Acc", Icons.account_balance, "Direct Transfer", _withdrawType == "Bank"), 
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Dynamic Content based on Selection
                      if (_withdrawType == "Pay App") ...[
                          if (_selectedPayApp != null) ...[
                              Text(
                                "Selected Payment App",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                  onTap: () => _showWithdrawalMethodSelector("Select Payment App", _methods, (method) {
                                      setState(() {
                                          _selectedPayApp = method;
                                          Navigator.pop(context);
                                      });
                                  }),
                                  child: _buildPaymentAppItem(_selectedPayApp!, isSelected: true),
                              ),
                          ]
                      ] else if (_withdrawType == "UPI") ...[
                          if (_selectedUPI != null) ...[
                              Text(
                                "Selected UPI ID",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                  onTap: () => _showWithdrawalMethodSelector("Select UPI ID", _upiMethods, (method) {
                                      setState(() {
                                          _selectedUPI = method;
                                          Navigator.pop(context);
                                      });
                                  }),
                                  child: _buildPaymentAppItem(_selectedUPI!, isSelected: true),
                              ),
                          ]
                      ] else if (_withdrawType == "Bank") ...[
                           if (_selectedBank != null) ...[
                              Text(
                                "Selected Bank Account",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                  onTap: () => _showWithdrawalMethodSelector("Select Bank Account", _bankMethods, (method) {
                                      setState(() {
                                          _selectedBank = method;
                                          Navigator.pop(context);
                                      });
                                  }),
                                  child: _buildPaymentAppItem(_selectedBank!, isSelected: true),
                              ),
                          ]
                      ],
                      
                      
                      const SizedBox(height: 12),


                      // Recent Withdrawals
                        Text(
                        "Recent Withdrawals",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildWithdrawalItem("\$250.00", "Feb 3, 2026", "Bank of America **** 4532", "Completed"),
                      _buildWithdrawalItem("\$100.00", "Jan 28, 2026", "Chase Bank **** 7821", "Processing"),
                      
                      const SizedBox(height: 80), // Space for button
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Button
          Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: SafeArea(
                  child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                          onPressed: () {
                              // Handle withdraw action
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 5,
                          ),
                          child: Text(
                              "Withdraw ${ _amountController.text.isEmpty ? '' : '\$${_amountController.text}' }",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                              ),
                          ),
                      ),
                  ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawalItem(String amount, String date, String bank, String status) {
      Color statusColor = status == "Completed" ? AppColors.primaryGreen : const Color(0xFFFFA000);
      Color statusBg = status == "Completed" ? const Color(0xFFE8F5E9) : const Color(0xFFFFF8E1);
      
      return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
          ),
          child: Row(
              children: [
                   Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: const Color(0xFFF2FBF5), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.attach_money, color: AppColors.primaryGreen),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(amount, style: GoogleFonts.barlowCondensed(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87)),
                              Text(date, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 2),
                              Text(bank, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                          ],
                      ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                          status,
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: statusColor),
                      ),
                  )
              ],
          ),
      );
  }
}

// Helper class for Dashed Border
class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;
  final Widget child;

  const DashedRect(
      {super.key,
      this.color = Colors.black,
      this.strokeWidth = 1.0,
      this.gap = 5.0,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRectPainter(color: color, strokeWidth: strokeWidth, gap: gap),
      child: child,
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedRectPainter(
      {required this.color, required this.strokeWidth, required this.gap});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: const Point(0, 0),
      b: Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: Point(x, 0),
      b: Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: Point(0, y),
      b: Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: const Point(0, 0),
      b: Point(0, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required Point<double> a,
    required Point<double> b,
    required double gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    Point<double> currentPoint = Point(a.x, a.y);

    num radians = atan(size.height / size.width);

    num dx = cos(radians) * gap < 0
        ? cos(radians) * gap * -1
        : cos(radians) * gap;

    num dy = sin(radians) * gap < 0
        ? sin(radians) * gap * -1
        : sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x, currentPoint.y)
          : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class WithdrawalMethod {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;

  WithdrawalMethod({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
