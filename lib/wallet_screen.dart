import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'withdraw_screen.dart';
import 'settle_payment_screen.dart' hide PaymentMethod;
import 'add_money_screen.dart' hide PaymentMethod;
import 'constants.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with AutomaticKeepAliveClientMixin {
  String _selectedFilter = "All";

  @override
  bool get wantKeepAlive => true;

  String _paymentType = "Pay App"; // Default selection
  
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

  final List<Map<String, dynamic>> _transactions = [
    {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#01234",
      "desc": "Delivery earnings",
      "time": "2 hours ago",
      "amount": "+₹8.50",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.account_balance,
      "title": "Bank Transfer",
      "id": "",
      "desc": "Withdrawn to Bank ****4532",
      "time": "Yesterday",
      "amount": "₹150.00",
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
      "amount": "+₹12.30",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.local_gas_station,
      "title": "Fuel Expense",
      "id": "",
      "desc": "Gasoline purchase",
      "time": "2 days ago",
      "amount": "₹25.00",
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
      "amount": "+₹15.75",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.trending_up,
      "title": "Weekly Bonus",
      "id": "",
      "desc": "Performance bonus",
      "time": "3 days ago",
      "amount": "+₹50.00",
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
      "amount": "₹45.00",
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
      "amount": "+₹9.20",
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
    super.build(context);
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
            bottom: false,
            child: Column(
              children: [
                // Top Sections (Header + Floating Card)
                 Padding(
                   padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
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
                              "₹789.00",
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
                  child: CustomScrollView(
                    slivers: [
                      // Scrollable Stats Row
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                          child: Row(
                            children: [
                              Expanded(child: _buildStatCard("This Week", "₹245", const Color(0xFF4CAF50))),
                              const SizedBox(width: 16),
                              Expanded(child: _buildStatCard("This Month", "₹1,024", Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                      
                      // Transaction History Sticky Header
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _StickyHeaderDelegate(
                          child: Container(
                            color: const Color(0xFFF5F5F5), // Match background color to obscure scrolling stats
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Transaction History", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    _buildFilterChip("All"),
                                    const SizedBox(width: 12),
                                    _buildFilterChip("Credit"),
                                    const SizedBox(width: 12),
                                    _buildFilterChip("Debit"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Transactions List
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final t = filteredTransactions[index];
                              return Padding(
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
                              );
                            },
                            childCount: filteredTransactions.length,
                          ),
                        ),
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

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xFFF5F5F5), // Ensure background covers scrolling elements
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  @override
  double get maxExtent => 90.0; 

  @override
  double get minExtent => 90.0;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return true;
  }
}
