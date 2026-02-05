import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0), // Light grey background
      body: Stack(
        children: [
          // Green Header Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 280,
              color: const Color(0xFF4CAF50), // Main Green
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button Removed for persistent nav
                      Text(
                        "Wallet",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 24), // Center gravity adjustment if needed
                    ],
                  ),
                ),
                
                const SizedBox(height: 10),

                // Fixed Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        // Balance Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
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
                                style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600, // Bold but not too heavy
                                  color: const Color(0xFF2C3E50),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
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
                                      onPressed: () {},
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

                        // Stats Row (This Week / This Month)
                        Row(
                          children: [
                            Expanded(child: _buildStatCard("This Week", "\$245", const Color(0xFF4CAF50))),
                            const SizedBox(width: 16),
                            Expanded(child: _buildStatCard("This Month", "\$1,024", Colors.blue)),
                          ],
                        ),

                        const SizedBox(height: 24),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

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
                            _buildFilterChip("All", true),
                            const SizedBox(width: 12),
                            _buildFilterChip("Credit", false),
                            const SizedBox(width: 12),
                            _buildFilterChip("Debit", false),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Transactions List
                        _buildTransactionCard(
                          icon: Icons.trending_up, 
                          title: "Order Delivery", 
                          id: "#01234", 
                          desc: "Delivery earnings", 
                          time: "2 hours ago", 
                          amount: "+\$8.50", 
                          isPositive: true
                        ),
                        const SizedBox(height: 12),
                        _buildTransactionCard(
                          icon: Icons.account_balance, // Banking icon
                          title: "Bank Transfer", 
                          id: "", 
                          desc: "Withdrawn to Bank ****4532", 
                          time: "Yesterday", 
                          amount: "\$150.00", 
                          isPositive: false,
                          isWithdrawal: true
                        ),
                         const SizedBox(height: 12),
                        _buildTransactionCard(
                          icon: Icons.trending_up, 
                          title: "Order Delivery", 
                          id: "#01189", 
                          desc: "Delivery earnings", 
                          time: "Yesterday", 
                          amount: "+\$12.30", 
                          isPositive: true
                        ),
                        const SizedBox(height: 12),
                        _buildTransactionCard(
                           icon: Icons.local_gas_station,
                           title: "Fuel Expense",
                           id: "",
                           desc: "Gasoline purchase",
                           time: "2 days ago",
                           amount: "\$25.00",
                           isPositive: false,
                           isWithdrawal: true, // Red icon bg
                           customIconBg: const Color(0xFFFFEBEE),
                           customIconColor: Colors.red,
                        ),
                         const SizedBox(height: 12),
                        _buildTransactionCard(
                          icon: Icons.trending_up, 
                          title: "Order Delivery", 
                          id: "#00987", 
                          desc: "Delivery earnings", 
                          time: "2 days ago", 
                          amount: "+\$15.75", 
                          isPositive: true
                        ),
                        const SizedBox(height: 12),
                         _buildTransactionCard(
                          icon: Icons.trending_up, 
                          title: "Weekly Bonus", 
                          id: "", 
                          desc: "Performance bonus", 
                          time: "3 days ago", 
                          amount: "+\$50.00", 
                          isPositive: true,
                          customIconBg: const Color(0xFFFFF3E0),
                          customIconColor: Colors.orange,
                        ),
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

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4CAF50) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
         style: GoogleFonts.poppins(
          fontSize: 14, 
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
