import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class CompletedOrdersScreen extends StatefulWidget {
  const CompletedOrdersScreen({super.key});

  @override
  State<CompletedOrdersScreen> createState() => _CompletedOrdersScreenState();
}

class _CompletedOrdersScreenState extends State<CompletedOrdersScreen> {
  String _selectedFilter = "All Orders";
  final List<String> _filters = ["All Orders", "Food", "Grocery", "Package"];

  // Mock Data
  final List<Map<String, dynamic>> _orders = [
    {
      "name": "Joseph Matthew",
      "id": "#01234",
      "type": "Food",
      "address": "123 Main St, Downtown",
      "time": "12:30 PM",
      "distance": "2.5 km",
      "earned": "₹8.50",
      "icon": Icons.restaurant,
      "bg": const Color(0xFFFFF3E0), // Orange tint
      "color": Colors.orange,
    },
    {
      "name": "Sarah Johnson",
      "id": "#01233",
      "type": "Grocery",
      "address": "456 Oak Avenue, Westside",
      "time": "11:45 AM",
      "distance": "3.8 km",
      "earned": "₹12.30",
      "icon": Icons.shopping_bag_outlined,
      "bg": const Color(0xFFE8F5E9), // Green tint
      "color": Colors.green,
    },
    {
      "name": "Michael Brown",
      "id": "#01232",
      "type": "Package",
      "address": "789 Elm Street, Eastside",
      "time": "10:15 AM",
      "distance": "1.2 km",
      "earned": "₹6.75",
      "icon": Icons.local_shipping_outlined,
      "bg": const Color(0xFFE3F2FD), // Blue tint
      "color": Colors.blue,
    },
     {
      "name": "Emily Davis",
      "id": "#01231",
      "type": "Food",
      "address": "321 Pine Road, North District",
      "time": "09:30 AM",
      "distance": "4.5 km",
      "earned": "₹15.00",
      "icon": Icons.restaurant,
      "bg": const Color(0xFFFFF3E0), 
      "color": Colors.orange,
    },
     {
      "name": "David Wilson",
      "id": "#01230",
      "type": "Grocery",
      "address": "567 Maple Drive, South End",
      "time": "08:20 AM",
      "distance": "2.1 km",
      "earned": "₹9.25",
      "icon": Icons.shopping_bag_outlined,
      "bg": const Color(0xFFE8F5E9),
      "color": Colors.green,
    },
     {
      "name": "Lisa Anderson",
      "id": "#01229",
      "type": "Food",
      "address": "890 Cedar Lane, Central",
      "time": "06:45 PM",
      "distance": "3.2 km",
      "earned": "₹11.50",
      "icon": Icons.restaurant,
      "bg": const Color(0xFFFFF3E0), 
      "color": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Green Header Background
          Positioned(
            top: 0,
            left: -5,
            right: -5,
            child: Container(
              height: 260, // Compact height to fit all elements
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
                           
                           // Title
                           Text(
                                 "Completed Orders",
                                 style: GoogleFonts.barlowCondensed(
                                   fontSize: 32,
                                   fontWeight: FontWeight.w700,
                                   color: Colors.white,
                                 ),
                               ),
                         ],
                       ),
                       const SizedBox(height: 5), // Minimized spacing

                       // Summary Cards Row

                       const SizedBox(height: 24),

                       // Summary Cards Row
                       Row(
                         children: [
                           Expanded(
                             child: _buildSummaryCard("Total Completed", "8", Colors.white),
                           ),
                           const SizedBox(width: 16),
                            Expanded(
                             child: _buildSummaryCard("Total Earned", "₹92.05", Colors.white),
                           ),
                         ],
                       ),

                       const SizedBox(height: 10), // Reduced spacing to fit search bar compact

                       // Search Bar & Filter (Moved to Header)
                       Row(
                         children: [
                           Expanded(
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 16),
                               height: 50,
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(25),
                                 boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
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
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
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

                        // Filter Chips
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
                                      color: isSelected ? AppColors.primaryGreen : Colors.white,
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

                        // List of Orders
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            itemCount: _orders.length,
                            itemBuilder: (context, index) {
                              final order = _orders[index];
                              if (_selectedFilter != "All Orders" && order["type"] != _selectedFilter && !(_selectedFilter == "Food" && order["type"] == "Food")) return const SizedBox.shrink(); // Simple filter logic

                              return _buildOrderCard(order);
                            },
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

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
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
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Completed",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.success),
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
               // Earned Amount
               Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   Text("Earned", style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
                   Text(
                     order["earned"],
                     style: GoogleFonts.barlowCondensed(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.success,
                      ),
                   )
                 ],
               )
             ],
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
