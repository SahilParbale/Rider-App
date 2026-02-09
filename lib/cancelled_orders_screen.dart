import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class CancelledOrdersScreen extends StatefulWidget {
  const CancelledOrdersScreen({super.key});

  @override
  State<CancelledOrdersScreen> createState() => _CancelledOrdersScreenState();
}

class _CancelledOrdersScreenState extends State<CancelledOrdersScreen> {
  String _selectedFilter = "All Orders";
  final List<String> _filters = ["All Orders", "Food", "Grocery", "Package"];

  // Mock Data for Cancelled Orders
  final List<Map<String, dynamic>> _orders = [
    {
      "name": "James Wilson",
      "id": "#01240",
      "type": "Food",
      "address": "445 Park Lane, Uptown",
      "time": "03:45 PM",
      "distance": "4.2 km",
      "cancelledFrom": "Customer",
      "reason": "Customer unavailable",
      "icon": Icons.restaurant,
      "bg": const Color(0xFFFFF3E0), 
      "color": Colors.orange,
    },
    {
      "name": "Amanda Clark",
      "id": "#01238",
      "type": "Grocery",
      "address": "789 Valley Street, Midtown",
      "time": "01:20 PM",
      "distance": "2.9 km",
      "cancelledFrom": "Restaurant",
      "reason": "Restaurant closed",
      "icon": Icons.shopping_bag_outlined,
      "bg": const Color(0xFFE8F5E9),
      "color": Colors.green,
    },
    {
      "name": "Kevin Lee",
      "id": "#01235",
      "type": "Package",
      "address": "234 Hill Road, Downtown",
      "time": "11:00 AM",
      "distance": "1.8 km",
      "cancelledFrom": "Customer",
      "reason": "Wrong address",
      "icon": Icons.local_shipping_outlined,
      "bg": const Color(0xFFE3F2FD),
      "color": Colors.blue,
    },
     {
      "name": "Rachel Green",
      "id": "#01225",
      "type": "Food",
      "address": "567 Beach Avenue, Seaside",
      "time": "07:30 PM",
      "distance": "6.5 km",
      "cancelledFrom": "Restaurant",
      "reason": "Order not prepared",
      "icon": Icons.restaurant,
      "bg": const Color(0xFFFFF3E0), 
      "color": Colors.orange,
    },
     {
      "name": "Tom Harris",
      "id": "#01220",
      "type": "Grocery",
      "address": "890 Forest Drive, Woodland",
      "time": "02:15 PM",
      "distance": "3.5 km",
      "cancelledFrom": "System",
      "reason": "Payment failed",
      "icon": Icons.shopping_bag_outlined,
      "bg": const Color(0xFFE8F5E9),
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Red Header Background instead of Green
          Positioned(
            top: 0,
            left: -5,
            right: -5,
            child: Container(
              height: 260, 
              decoration: const BoxDecoration(
                color: Color(0xFFF90F24), // Red color from photos
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
                           Text(
                                 "Cancelled Orders",
                                 style: GoogleFonts.barlowCondensed(
                                   fontSize: 32,
                                   fontWeight: FontWeight.w700,
                                   color: Colors.white,
                                 ),
                               ),
                         ],
                       ),
                       const SizedBox(height: 5),
                       const SizedBox(height: 24),

                       // Summary Cards Row
                       Row(
                         children: [
                           Expanded(
                             child: _buildSummaryCard("Total Cancelled", "5"),
                           ),
                           const SizedBox(width: 16),
                            Expanded(
                             child: _buildSummaryCard("By Customer", "2"),
                           ),
                         ],
                       ),

                       const SizedBox(height: 10),

                       // Search Bar
                       Row(
                         children: [
                           Expanded(
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 16),
                               height: 50,
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(25),
                                 boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
                               ),
                               child: Row(
                                 children: [
                                   Icon(Icons.search, color: Colors.grey[400]),
                                   const SizedBox(width: 8),
                                   Expanded(
                                     child: TextField(
                                       decoration: InputDecoration(
                                         border: InputBorder.none,
                                         hintText: "Search...",
                                         hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           const SizedBox(width: 12),
                           Container(
                             padding: const EdgeInsets.all(12),
                             decoration: BoxDecoration(
                               color: Colors.white,
                               shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
                             ),
                             child: const Icon(Icons.filter_list, color: Colors.black87),
                           ),
                         ],
                       ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),

                // Filters & List
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                       // color: Color(0xFFF5F5F5),
                    ),
                    child: Column(
                      children: [

                        const SizedBox(height: 16),

                        // Filter Chips (Fixed)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: _filters.map((filter) {
                              bool isSelected = _selectedFilter == filter;
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedFilter = filter;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFFF90F24) : Colors.white, // Red filter
                                      borderRadius: BorderRadius.circular(20),
                                       boxShadow: [if(!isSelected) BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
                                    ),
                                    child: Text(
                                      filter,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? Colors.white : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        
                        const SizedBox(height: 16),

                        // Scrollable Area (Info Box + List)
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.only(bottom: 20),
                            children: [
                              // Info Box
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDE8EA).withOpacity(0.9), // Light Red
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.info_outline, color: AppColors.error, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "About Cancellations",
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: const Color(0xFF8C1D18)),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "High cancellation rates may affect your account standing. Customer cancellations don't impact your rating.",
                                            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF8C1D18)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),

                              // List of Orders
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: _orders.map((order) {
                                     if (_selectedFilter != "All Orders" && order["type"] != _selectedFilter && !(_selectedFilter == "Food" && order["type"] == "Food")) return const SizedBox.shrink();
                                     
                                     return _buildOrderCard(order);
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  // Same style summary card as Completed but with Red Accent
  Widget _buildSummaryCard(String title, String value) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.barlowCondensed(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          // Top Row: Icon, Name/ID, Status
          Row(
            children: [
               Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: order["bg"],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(order["icon"], color: order["color"], size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order["name"],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      "${order["type"]} • Order ID ${order["id"]}",
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.errorLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Cancelled",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.error),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
           // Address Row
           Row(
             children: [
               const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
               const SizedBox(width: 4),
               Text(order["address"], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
             ],
           ),
           const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
           
           // Stats Row
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               _buildStat(Icons.access_time, "Time", order["time"]),
               _buildStat(Icons.place_outlined, "Distance", order["distance"]),
               // Cancelled By
               Row(
                 children: [
                   const Icon(Icons.cancel_outlined, size: 16, color: AppColors.error),
                    const SizedBox(width: 6),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Cancelled By", style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
                       Text(
                         order["cancelledFrom"],
                         style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.error,
                          ),
                       )
                     ],
                   )
                 ],
               )
             ],
           ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cancellation Reason", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(order["reason"], style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(label, style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
             Text(value, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        )
      ],
    );
  }
}
