import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  final double _currentBalance = 789.00;
  String _paymentType = "Pay App"; // Default selection
  
  // Track selection per type
  PaymentMethod? _selectedPayApp;
  PaymentMethod? _selectedUPI;
  PaymentMethod? _selectedBank;

  final List<PaymentMethod> _payAppMethods = [
    PaymentMethod(id: "1", name: "Google Pay", subtitle: "upi@oksbi", icon: Icons.account_balance_wallet, color: Colors.blue),
    PaymentMethod(id: "2", name: "PhonePe", subtitle: "upi@ybl", icon: Icons.phonelink_ring, color: Colors.purple),
    PaymentMethod(id: "3", name: "Paytm", subtitle: "upi@paytm", icon: Icons.payment, color: Colors.indigo),
  ];

  final List<PaymentMethod> _upiMethods = [
      PaymentMethod(id: "1", name: "Sarah UPI", subtitle: "sarah@upi", icon: Icons.alternate_email, color: Colors.orange),
      PaymentMethod(id: "2", name: "Work UPI", subtitle: "sarah.work@okicici", icon: Icons.work, color: Colors.blueGrey),
  ];

  final List<PaymentMethod> _bankMethods = [ 
      PaymentMethod(id: "1", name: "HDFC Debit Card", subtitle: "**** 4532", icon: Icons.credit_card, color: Colors.red),
      PaymentMethod(id: "2", name: "SBI Netbanking", subtitle: "000234912", icon: Icons.account_balance, color: Colors.blue[900]!),
  ];

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_updateState);
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateState);
    _amountController.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  void _selectAmount(String amount) {
    setState(() {
      _amountController.text = amount;
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
                      
                      if (_paymentType == "Pay App") {
                          _showPaymentMethodSelector("Select Payment App", _payAppMethods, (method) {
                              setState(() {
                                  _selectedPayApp = method;
                                  Navigator.pop(context);
                              });
                          });
                      } else if (_paymentType == "UPI") {
                          _showPaymentMethodSelector("Select UPI ID", _upiMethods, (method) {
                              setState(() {
                                  _selectedUPI = method;
                                  Navigator.pop(context);
                              });
                          });
                      } else if (_paymentType == "Bank/Card") {
                          _showPaymentMethodSelector("Select Bank/Card", _bankMethods, (method) {
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
    double amountToAdd = double.tryParse(_amountController.text) ?? 0.0;
    double newBalance = _currentBalance + amountToAdd;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
           // Green Header Background (Consistent with other screens)
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
                // Header & Top Card Area
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Navigation Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                "BACK",
                                style: GoogleFonts.barlowCondensed(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF23AA49),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Add Money",
                                style: GoogleFonts.barlowCondensed(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Top up your wallet",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Current Balance Card (Green as per photo)
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Balance",
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "\$${_currentBalance.toStringAsFixed(2)}",
                              style: GoogleFonts.barlowCondensed(
                                color: const Color(0xFF2C3E50),
                                fontSize: 42,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                             Row(
                               children: [
                                 Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF69F0AE), shape: BoxShape.circle)),
                                 const SizedBox(width: 8),
                                 Text(
                                  "Add money to increase your wallet balance",
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
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Enter Amount Section
                        Text(
                          "Enter Amount",
                           style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primaryGreen, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "\$",
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.barlowCondensed(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                    hintStyle: GoogleFonts.barlowCondensed(
                                       fontSize: 28,
                                       fontWeight: FontWeight.w700,
                                       color: Colors.grey[400]
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Quick Add Buttons
                        Text(
                          "Quick Add",
                           style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ["50", "100", "200", "500"].map((amt) {
                            return GestureDetector(
                              onTap: () => _selectAmount(amt),
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 48) / 4, // 3 gaps of 16 (actually spaceAround/between might be better or fixed gap) roughly calculated
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                   boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.05),
                                        blurRadius: 5,
                                      ),
                                    ],
                                ),
                                child: Center(
                                  child: Text(
                                    "\$$amt",
                                    style: GoogleFonts.barlowCondensed(
                                      fontWeight: FontWeight.w600, // Condensed bold for numbers
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

                        // Payment Methods
                        Text(
                          "Select Payment Method",
                           style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
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
                            const SizedBox(width: 12),
                            _buildPaymentTypeCard("Bank/Card", Icons.credit_card, "Card/NetBanking", _paymentType == "Bank/Card"), 
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
                        ] else if (_paymentType == "Bank/Card") ...[
                             if (_selectedBank != null) ...[
                                Text(
                                  "Selected Bank/Card",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                GestureDetector(
                                    onTap: () => _showPaymentMethodSelector("Select Bank/Card", _bankMethods, (method) {
                                        setState(() {
                                            _selectedBank = method;
                                            Navigator.pop(context);
                                        });
                                    }),
                                    child: _buildPaymentMethodItem(_selectedBank!, isSelected: true),
                                ),
                            ]
                        ],

                         const SizedBox(height: 24),

                        // Summary
                         Text(
                          "Summary",
                           style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
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
                          child: Column(
                            children: [
                              _buildSummaryRow("Current Balance", "\$${_currentBalance.toStringAsFixed(2)}"),
                              const SizedBox(height: 8),
                              _buildSummaryRow("Amount to Add", "\$${amountToAdd.toStringAsFixed(0)}"),
                              const SizedBox(height: 8),
                              _buildSummaryRow("Transaction Fee", "Free", valueColor: AppColors.primaryGreen),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider()),
                              _buildSummaryRow("New Balance", "\$${newBalance.toStringAsFixed(2)}", isBold: true, valueColor: AppColors.primaryGreen, fontSize: 18),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100), // Space for button
                      ],
                    ),
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
                              // Handle Add Money
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16), // Rounded req?
                              ),
                              elevation: 5,
                          ),
                          child: Text(
                              "Add \$${amountToAdd.toStringAsFixed(0)} to Wallet",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
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



  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? valueColor, double fontSize = 14}) {
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
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            fontSize: isBold ? fontSize + 2 : fontSize + 2, // Condensed usually needs size bump
            color: valueColor ?? Colors.black87,
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
