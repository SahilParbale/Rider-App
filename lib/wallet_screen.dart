import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'withdraw_screen.dart';
import 'settle_payment_screen.dart';
import 'add_money_screen.dart';
import 'constants.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String _selectedFilter = "All";

  final List<Map<String, dynamic>> _transactions = [
    {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#01234",
      "desc": "Delivery earnings",
      "time": "2 hours ago",
      "amount": "+\$8.50",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.account_balance,
      "title": "Bank Transfer",
      "id": "",
      "desc": "Withdrawn to Bank ****4532",
      "time": "Yesterday",
      "amount": "\$150.00",
      "isPositive": false,
      "isWithdrawal": true,
      "type": "Debit",
    },
    {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#01189",
      "desc": "Delivery earnings",
      "time": "Yesterday",
      "amount": "+\$12.30",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.local_gas_station,
      "title": "Fuel Expense",
      "id": "",
      "desc": "Gasoline purchase",
      "time": "2 days ago",
      "amount": "\$25.00",
      "isPositive": false,
      "isWithdrawal": true,
      "customIconBg": const Color(0xFFFFEBEE),
      "customIconColor": Colors.red,
      "type": "Debit",
    },
    {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#00987",
      "desc": "Delivery earnings",
      "time": "2 days ago",
      "amount": "+\$15.75",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.trending_up,
      "title": "Weekly Bonus",
      "id": "",
      "desc": "Performance bonus",
      "time": "3 days ago",
      "amount": "+\$50.00",
      "isPositive": true,
      "customIconBg": const Color(0xFFFFF3E0),
      "customIconColor": Colors.orange,
      "type": "Credit",
    },
    {
      "icon": Icons.shopping_bag_outlined,
      "title": "Equipment Buy",
      "id": "",
      "desc": "Delivery bag purchase",
      "time": "4 days ago",
      "amount": "\$45.00",
      "isPositive": false,
      "isWithdrawal": true,
      "type": "Debit",
    },
     {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#00852",
      "desc": "Delivery earnings",
      "time": "5 days ago",
      "amount": "+\$9.20",
      "isPositive": true,
      "type": "Credit",
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    if (_selectedFilter == "All") return _transactions;
    return _transactions.where((t) => t['type'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      body: Stack(
        children: [
          // Green Header Background
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
                // Top Sections (Header + Floating Card)
                 Padding(
                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       // Header Row
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                            Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "Wallet",
                                 style: GoogleFonts.barlowCondensed(
                                   fontSize: 32,
                                   fontWeight: FontWeight.w700,
                                   color: Colors.white,
                                 ),
                               ),
                               Text(
                                 "Manage your finances",
                                 style: GoogleFonts.poppins(
                                   fontSize: 10,
                                   color: Colors.white.withOpacity(0.9),
                                 ),
                               ),
                             ],
                           ),
                           // Status Icons (or profile)

                         ],
                       ),
                       const SizedBox(height: 20),

                       // Available Balance Card (Floating Style)
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
                             Row(
                               children: [
                                 Icon(Icons.account_balance_wallet_outlined, color: Colors.grey[400], size: 20),
                                 const SizedBox(width: 8),
                                 Text(
                                  "Available Balance",
                                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                                ),
                               ],
                             ),
                            const SizedBox(height: 8),
                            Text(
                              "\$789.00",
                              style: GoogleFonts.barlowCondensed(
                                fontSize: 42,
                                fontWeight: FontWeight.w700, 
                                color: const Color(0xFF2C3E50),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const WithdrawScreen()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4CAF50), // Green
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.arrow_outward, size: 18),
                                        const SizedBox(width: 8),
                                        Text("Withdraw", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const AddMoneyScreen()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF5F5F5), // Light grey
                                      foregroundColor: Colors.black87,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add, size: 18),
                                        const SizedBox(width: 8),
                                        Text("Add Money", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                     ],
                   ),
                 ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16), // Match Withdraw padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        // Stats Row
                        Row(
                          children: [
                            Expanded(child: _buildStatCard("This Week", "\$245", const Color(0xFF4CAF50))),
                            const SizedBox(width: 16),
                            Expanded(child: _buildStatCard("This Month", "\$1,024", Colors.blue)),
                          ],
                        ),
                        const SizedBox(height: 24),


                        // Payment Methods
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Payment Methods", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                            Text("+ Add", style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF4CAF50), fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildPaymentMethodItem(
                          icon: Icons.account_balance,
                          title: "Bank of America",
                          subtitle: "Account ****4532",
                          isPrimary: true,
                          color: Colors.blue[100]!,
                          iconColor: Colors.blue,
                        ),
                        const SizedBox(height: 12),
                        _buildPaymentMethodItem(
                          icon: Icons.credit_card,
                          title: "Visa Card",
                          subtitle: "**** **** **** 8921",
                          isPrimary: false,
                          color: Colors.orange[100]!,
                          iconColor: Colors.orange,
                        ),

                        const SizedBox(height: 24),

                        // Transaction History
                        Text("Transaction History", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        
                        // Filters
                        Row(
                          children: [
                            _buildFilterChip("All"),
                            const SizedBox(width: 12),
                            _buildFilterChip("Credit"),
                            const SizedBox(width: 12),
                            _buildFilterChip("Debit"),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Transactions List
                        ...filteredTransactions.map((t) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildTransactionCard(
                             icon: t['icon'],
                             title: t['title'],
                             id: t['id'],
                             desc: t['desc'],
                             time: t['time'],
                             amount: t['amount'],
                             isPositive: t['isPositive'],
                             isWithdrawal: t['isWithdrawal'] ?? false,
                             customIconBg: t['customIconBg'],
                             customIconColor: t['customIconColor'],
                          ),
                        )),
                        
                        const SizedBox(height: 30),
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

  Widget _buildStatCard(String title, String amount, Color trendColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: trendColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.trending_up, size: 16, color: trendColor),
              ),
              const SizedBox(width: 8),
              Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Text(amount, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: trendColor)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isPrimary,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
         boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
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
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    if (isPrimary) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text("Primary", style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF4CAF50), fontWeight: FontWeight.w600)),
                      ),
                    ]
                  ],
                ),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4CAF50) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
             if(!isSelected)
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
        ),
        child: Text(
          label,
           style: GoogleFonts.poppins(
            fontSize: 14, 
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCard({
    required IconData icon,
    required String title,
    required String id,
    required String desc,
    required String time,
    required String amount,
    required bool isPositive,
    bool isWithdrawal = false,
    Color? customIconBg,
    Color? customIconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
             decoration: BoxDecoration(
              color: customIconBg ?? (isWithdrawal ? Colors.blue[50] : const Color(0xFFE8F5E9)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon, 
              color: customIconColor ?? (isWithdrawal ? Colors.blue : const Color(0xFF4CAF50)),
              size: 24
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(id.isEmpty ? title : "$title $id", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text(desc, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                Text(time, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400])),
              ],
            ),
          ),
          Text(
            amount,
             style: GoogleFonts.poppins(
               fontSize: 16, 
               fontWeight: FontWeight.w600, 
               color: isWithdrawal && !isPositive ? Colors.red : (isPositive ? const Color(0xFF4CAF50) : Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
