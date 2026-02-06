import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class SettlePaymentScreen extends StatefulWidget {
  const SettlePaymentScreen({super.key});

  @override
  State<SettlePaymentScreen> createState() => _SettlePaymentScreenState();
}

class _SettlePaymentScreenState extends State<SettlePaymentScreen> {
  final double _totalAmountDue = 189.00;
  final TextEditingController _amountController = TextEditingController();
  
  String _selectedPaymentMethod = "Credit/Debit Card";
  
  @override
  void initState() {
    super.initState();
    _amountController.text = _totalAmountDue.toStringAsFixed(0);
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    setState(() {});
  }

  void _setAmount(double amount) {
    setState(() {
      _amountController.text = amount.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    double enteredAmount = double.tryParse(_amountController.text) ?? 0.0;
    double remainingBalance = (_totalAmountDue - enteredAmount).clamp(0.0, _totalAmountDue);

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
              height: 220,
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
                // Fixed Header Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                                "BACK",
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
                                "Settle Payment",
                                style: GoogleFonts.barlowCondensed(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Pay your dues to continue earning",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Amount Due Card
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
                              "Total Amount Due",
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                             Text(
                              "\$${_totalAmountDue.toStringAsFixed(0)}",
                              style: GoogleFonts.barlowCondensed(
                                color: const Color(0xFFE53935), // Red/Orange for Due
                                fontSize: 42,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
                                 const SizedBox(width: 6),
                                 Text(
                                  "Payment required",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                                             ),
                               ],
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
                        "Payment Amount",
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
                                style: GoogleFonts.barlowCondensed(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0",
                                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Quick Buttons
                      Row(
                         children: [
                           Expanded(
                             child: GestureDetector(
                               onTap: () => _setAmount(_totalAmountDue * 0.5),
                               child: Container(
                                 padding: const EdgeInsets.symmetric(vertical: 12),
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(12),
                                   border: Border.all(color: Colors.grey[300]!),
                                 ),
                                 child: Center(
                                   child: Text(
                                     "Pay 50%",
                                     style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black87),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                           const SizedBox(width: 16),
                           Expanded(
                             child: GestureDetector(
                               onTap: () => _setAmount(_totalAmountDue),
                               child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                   border: Border.all(color: AppColors.primaryGreen),
                                 ),
                                 child: Center(
                                   child: Text(
                                     "Pay Full Amount",
                                     style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: AppColors.primaryGreen),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         ],
                      ),

                       const SizedBox(height: 24),

                       // Payment Methods
                       Text(
                        "Pay Via",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      _buildPaymentMethodOption(
                         icon: Icons.credit_card,
                         title: "Credit/Debit Card",
                         subtitle: "**** 4532",
                         value: "Credit/Debit Card",
                       ),
                        _buildPaymentMethodOption(
                         icon: Icons.account_balance_wallet,
                         title: "Wallet Balance",
                         subtitle: "\$450 available",
                         value: "Wallet Balance",
                         iconBg: const Color(0xFFFFF3E0),
                         iconColor: Colors.orange,
                       ),
                       _buildPaymentMethodOption(
                         icon: Icons.account_balance,
                         title: "Bank Transfer",
                         subtitle: "Direct transfer",
                         value: "Bank Transfer",
                         iconBg: const Color(0xFFE3F2FD),
                         iconColor: Colors.blue,
                       ),

                       const SizedBox(height: 24),

                        // Payment Summary
                        Container(
                           padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(16),
                             boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
                           ),
                           child: Column(
                             children: [
                                _buildSummaryRow("Payment Amount", "\$${enteredAmount.toStringAsFixed(0)}"),
                                const SizedBox(height: 12),
                                _buildSummaryRow("Processing Fee", "\$0", boldValue: true),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Divider(height: 1),
                                ),
                                _buildSummaryRow("Total Payment", "\$${enteredAmount.toStringAsFixed(0)}", valueColor: AppColors.primaryGreen, boldValue: true, fontSize: 16),
                                const SizedBox(height: 6),
                                _buildSummaryRow("Remaining Balance", "\$${remainingBalance.toStringAsFixed(0)}", valueColor: const Color(0xFFE53935), boldValue: true),
                             ],
                           ),
                        ),

                      const SizedBox(height: 100),
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
                              // Handle Settlement
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 5,
                          ),
                          child: Text(
                              "Settle \$${enteredAmount.toStringAsFixed(0)} Now",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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

   Widget _buildPaymentMethodOption({
      required IconData icon,
      required String title,
      required String subtitle,
      required String value,
      Color iconBg = const Color(0xFFE8F5E9),
      Color iconColor = AppColors.primaryGreen,
  }) {
      bool isSelected = _selectedPaymentMethod == value;
      return GestureDetector(
          onTap: () {
              setState(() {
                  _selectedPaymentMethod = value;
              });
          },
          child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                      width: 1,
                  ),
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
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: iconBg,
                              borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(icon, color: iconColor, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                      title,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black87,
                                      ),
                                  ),
                                  Text(
                                      subtitle,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                      ),
                                  ),
                              ],
                          ),
                      ),
                      Icon(
                          isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: isSelected ? AppColors.primaryGreen : Colors.grey[300],
                      ),
                  ],
              ),
          ),
      );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor, bool boldValue = false, double fontSize = 14}) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Text(
                  label,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                  ),
              ),
              Text(
                  value,
                  style: GoogleFonts.barlowCondensed(
                      fontSize: fontSize + 2,
                      fontWeight: boldValue ? FontWeight.w700 : FontWeight.w500,
                      color: valueColor ?? AppColors.primaryText,
                  ),
              ),
          ],
      );
  }
}
