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
  
  String? _paymentType; // No default selection
  
  // Track selection per type
  PaymentMethod? _selectedPayApp;
  PaymentMethod? _selectedUPI;

  final List<PaymentMethod> _payAppMethods = [
    PaymentMethod(id: "1", name: "Google Pay", subtitle: "upi@oksbi", icon: Icons.account_balance_wallet, color: Colors.blue),
    PaymentMethod(id: "2", name: "PhonePe", subtitle: "upi@ybl", icon: Icons.phonelink_ring, color: Colors.purple),
    PaymentMethod(id: "3", name: "Paytm", subtitle: "upi@paytm", icon: Icons.payment, color: Colors.indigo),
  ];

  final List<PaymentMethod> _upiMethods = [
      PaymentMethod(id: "1", name: "Sarah UPI", subtitle: "sarah@upi", icon: Icons.alternate_email, color: Colors.orange),
      PaymentMethod(id: "2", name: "Work UPI", subtitle: "sarah.work@okicici", icon: Icons.work, color: Colors.blueGrey),
  ];

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

  void _showPaymentMethodSelector(String title, List<PaymentMethod> methods, Function(PaymentMethod) onSelect) {
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
                  ...methods.map((method) => _buildPaymentMethodItem(method, onSelect: onSelect)),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTypeCard(String title, IconData icon, String subtitle, bool isSelected) {
      return Expanded(
          child: GestureDetector(
              onTap: () {
                  setState(() {
                      _paymentType = title;
                  });
                  
                  if (title == "Pay App") {
                      _showPaymentMethodSelector("Select Payment App", _payAppMethods, (method) {
                          setState(() {
                              _selectedPayApp = method;
                              Navigator.pop(context);
                          });
                      });
                  } else if (title == "UPI") {
                      _showPaymentMethodSelector("Select UPI ID", _upiMethods, (method) {
                          setState(() {
                              _selectedUPI = method;
                              Navigator.pop(context);
                          });
                      });
                  }
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
                              textAlign: TextAlign.center,
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

  Widget _buildPaymentMethodItem(PaymentMethod method, {bool isSelected = false, Function(PaymentMethod)? onSelect}) {
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
                              "Pay",
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
                // Fixed Header Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
                              "₹${_totalAmountDue.toStringAsFixed(0)}",
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
                        "Select Payment Method",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Payment Type Selection Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPaymentTypeCard("Pay App", Icons.account_balance_wallet, "Quick payment", _paymentType == "Pay App"),
                          const SizedBox(width: 12),
                          _buildPaymentTypeCard("UPI", Icons.payment, "Pay via UPI", _paymentType == "UPI"),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Dynamic Content based on Selection
                      if (_paymentType == "Pay App") ...[
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
                                  onTap: () => _showPaymentMethodSelector("Select Payment App", _payAppMethods, (method) {
                                      setState(() {
                                          _selectedPayApp = method;
                                          Navigator.pop(context);
                                      });
                                  }),
                                  child: _buildPaymentMethodItem(_selectedPayApp!, isSelected: true),
                              ),
                          ]
                      ] else if (_paymentType == "UPI") ...[
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
                                  onTap: () => _showPaymentMethodSelector("Select UPI ID", _upiMethods, (method) {
                                      setState(() {
                                          _selectedUPI = method;
                                          Navigator.pop(context);
                                      });
                                  }),
                                  child: _buildPaymentMethodItem(_selectedUPI!, isSelected: true),
                              ),
                          ]
                      ],

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
                                _buildSummaryRow("Payment Amount", "₹${enteredAmount.toStringAsFixed(0)}"),
                                const SizedBox(height: 12),
                                _buildSummaryRow("Processing Fee", "₹0", boldValue: true),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Divider(height: 1),
                                ),
                                _buildSummaryRow("Total Payment", "₹${enteredAmount.toStringAsFixed(0)}", valueColor: AppColors.primaryGreen, boldValue: true, fontSize: 16),
                                const SizedBox(height: 6),
                                _buildSummaryRow("Remaining Balance", "₹${remainingBalance.toStringAsFixed(0)}", valueColor: const Color(0xFFE53935), boldValue: true),
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
                              "Settle ₹${enteredAmount.toStringAsFixed(0)} Now",
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

class PaymentMethod {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;

  PaymentMethod({
    required this.id, 
    required this.name, 
    required this.subtitle, 
    required this.icon, 
    required this.color
  });
}
