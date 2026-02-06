import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackingScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const TrackingScreen({super.key, this.onBack});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  bool get wantKeepAlive => true;

  static const LatLng _kPizzaHutt = LatLng(40.732128, -73.999619); // 237 E 14th St
  static const LatLng _kUser = LatLng(40.735, -73.99); // Approx nearby
  static const LatLng _kScooter = LatLng(40.7335, -73.995); // Midpoint

  // Custom marker approximation with standard markers for now
  final Set<Marker> _markers = {
    // Pizza Hutt Marker
    const Marker(
      markerId: MarkerId('pizzahutt'),
      position: _kPizzaHutt,
      infoWindow: InfoWindow(title: 'Pizza Hutt', snippet: '237 E 14th New York, NY 10003'),
    ),
     // Scooter Marker
    Marker(
      markerId: const MarkerId('scooter'),
      position: _kScooter,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    // User/Target Marker
    const Marker(
      markerId: MarkerId('user'),
      position: _kUser,
    ),
  };

  final Set<Polyline> _polylines = {
    const Polyline(
      polylineId: PolylineId('route'),
      points: [
        _kPizzaHutt,
        LatLng(40.733, -73.999), 
        LatLng(40.733, -73.995),
        _kScooter,
        LatLng(40.734, -73.995),
        LatLng(40.734, -73.99),
        _kUser
      ],
      color: Color(0xFF2E7D32), // Green
      width: 5,
    ),
  };

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          // 1. Google Map
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: _kScooter,
              zoom: 15,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),

          // 2. Top Bar (Header)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                   // Back Button Removed for persistent nav
                   // Instead, maybe a title or nothing
                  const Spacer(),
                ],
              ),
            ),
          ),

          // 3. Current Location Button (Top Right)
          Positioned(
            top: 50, // Below status bar area
            right: 8,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                   color: Color(0xFFE8F5E9), // Light green bg
                   shape: BoxShape.circle,
                   boxShadow: [
                     BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                   ],
                ),
                child: const Icon(Icons.my_location, color: Color(0xFF2E7D32)),
              ),
            ),
          ),

          // Back Button (Top Left) - Styled as Navbar Item
          Positioned(
            top: 50,
            left: 8,
            child: SafeArea(
              child: GestureDetector(
                onTap: widget.onBack,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                     color: const Color(0xFFF2FBF5), // Light green background like Home tab
                     borderRadius: BorderRadius.circular(30), // Pill shape
                     boxShadow: [
                       BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                     ],
                  ),
                  child: Text(
                    "BACK",
                    style: GoogleFonts.barlowCondensed(
                      color: const Color(0xFF23AA49),
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // // 4. "Pizza Hutt" Custom Label Overlay (Simulated)
          // Positioned(
          //   // Placing roughly where the restaurant marker is on screen (Static for demo)
          //   // In real app, use projection to get screen coordinates
          //   top: 300, 
          //   left: 80,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //     decoration: BoxDecoration(
          //       color: const Color(0xFF81C784).withOpacity(0.9),
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text("Pizza Hutt", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
          //         Text("237 E 14th New York, NY 10003", style: GoogleFonts.poppins(fontSize: 10)),
          //       ],
          //     ),
          //   ),
          // ),

          // 5. Bottom Sheet Information
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Header: Image + Name + Phone Call
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=pizza'), // Pizza avatar
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Restaurant Name",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "Pizza Hutt",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF81C784), // Lighter green
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.phone, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Route Timeline / Stepper
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.circle, size: 12, color: Color(0xFF81C784)), // Green dot
                          Container(width: 2, height: 30, color: const Color(0xFF81C784)), // Line
                          const Icon(Icons.location_on_outlined, size: 20, color: Color(0xFF2E7D32)), // Dark green pin
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // "You" Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("You", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                                    Text("23.7915° N, 90.3664° E", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.alarm, color: Colors.red, size: 20),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            // "Pick Up" Section
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text("Pick Up", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                                     Text("237 E 14th   New York, NY 10003", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Text("2 minute", style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Payment Info
                  Text(
                    "Payment Info : Online",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F), // Red
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32), // Green
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Arrived",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Bottom safe area space roughly
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
