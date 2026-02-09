import 'package:flutter/material.dart';
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
  String _selectedBank = "Bank of America";

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
                        "Withdraw To",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Bank Option 1
                      _buildBankOption("Bank of America", "**** **** **** 4532", true),
                      // Bank Option 2
                      _buildBankOption("Chase Bank", "**** **** **** 7821", false),
                      
                      const SizedBox(height: 24),
                      
                      // Processing Time Warning
                      Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFF8E1), // Light Amber
                              borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  const Icon(Icons.access_time, color: Color(0xFFFFA000), size: 24),
                                  const SizedBox(width: 12),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              Text(
                                                  "Processing Time",
                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
                                              ),
                                              const SizedBox(height: 4),
                                               Text(
                                                  "Withdrawals typically take 1-3 business days to process",
                                                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
                                              ),
                                          ],
                                      ),
                                  )
                              ],
                          ),
                      ),
                       const SizedBox(height: 24),

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

  Widget _buildBankOption(String name, String account, bool isSelected) {
      // For now, toggle logic is not fully implemented for multiple selection, just visual
      bool selected = _selectedBank == name;
      
      return GestureDetector(
          onTap: () {
              setState(() {
                  _selectedBank = name;
              });
          },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? AppColors.primaryGreen : Colors.transparent, width: 1),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.account_balance, color:  Color(0xFF1976D2)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black87)),
                    Text(account, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ),
              Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: selected ? AppColors.primaryGreen : Colors.grey[300],
              ),
            ],
          ),
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
