import 'package:flutter/material.dart';

import 'custom_map_pin.dart';
import 'bottom_navigation.dart';
import 'orders_screen.dart';
import 'destination_bottom_sheet.dart';
import 'notification_button.dart';
import 'notifications_panel.dart';
import 'pin_selection_overlay.dart';
import 'profile_screen.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  bool _showBottomSheet = false;
  bool _showLocationPin = false;
  bool _showNotifications = false;
  int _currentNavIndex = 0;
  Offset _mapOffset = Offset.zero;
  final DraggableScrollableController _bottomSheetController =
  DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    // Show bottom sheet on initial load since Home tab is selected by default
    _showBottomSheet = true;
  }

  @override
  void dispose() {
    _bottomSheetController.dispose();
    super.dispose();
  }

  void _showLocationBottomSheet() {
    setState(() {
      _showBottomSheet = true;
      _showLocationPin = false;
    });
  }

  void _showLocationPinSheet() {
    setState(() {
      _showLocationPin = true;
      _showBottomSheet = false;
      _mapOffset = Offset.zero;
      _showNotifications = false;
    });
  }

  void _toggleNotifications() {
    setState(() {
      _showNotifications = !_showNotifications;
    });
  }

  void _closeNotifications() {
    setState(() {
      _showNotifications = false;
    });
  }

  void _onNavTap(int index) async {
    if (index == _currentNavIndex) return;

    if (index == 1) {
      // Set index to 1 to highlight Profile tab
      setState(() {
        _currentNavIndex = 1;
      });

      // Navigate to Profile screen with transparent background
      await Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // Makes the route transparent
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          pageBuilder: (context, animation, secondaryAnimation) {
            return const ProfileScreen();
          },
        ),
      );

      // Reset to Home when returning from Profile
      setState(() {
        _currentNavIndex = 0;
        _showBottomSheet = true;
      });
      return;
    }

    setState(() {
      _currentNavIndex = index;
    });

    if (index == 0) {
      _showLocationBottomSheet();
    } else if (index == 3) {
      // Navigate to Orders screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OrdersScreen(),
        ),
      );
    }
    // Add index 2 (Messages) when that screen is ready
  }

  void _updateMapPosition(Offset delta) {
    setState(() {
      _mapOffset += delta;
    });
  }

  void _selectLocation() {
    print('Location selected with map offset: $_mapOffset');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrdersScreen(),
      ),
    );
  }

  void _onLocationSelected(String location) {
    print('Selected location: $location');
    // Navigate to OrdersScreen after selecting from list
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrdersScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Map Background with GestureDetector for map movement
          GestureDetector(
            onPanUpdate: _showLocationPin
                ? (details) {
              _updateMapPosition(details.delta);
            }
                : null,
            child: Transform.translate(
              offset: _mapOffset,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                ),
                child: Stack(
                  children: [
                    // Map image
                    Image.asset(
                      'assets/map.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF5F5F5),
                          child: const Center(
                            child: Text(
                              'Map not found\nPlace map.png in assets folder',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Fixed center pin
          Positioned(
            left: screenSize.width / 2 - 40,
            top: screenSize.height / 2 - 50,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: CustomMapPin(
                isActive: _showLocationPin,
              ),
            ),
          ),

          // Pin Selection Overlay (instructions, back button, select button)
          if (_showLocationPin)
            PinSelectionOverlay(
              onBack: () {
                setState(() {
                  _showLocationPin = false;
                  _showBottomSheet = true;
                  _mapOffset = Offset.zero;
                });
              },
              onSelect: _selectLocation,
            ),

          // Top notification icon (only show when not in pin mode)
          if (!_showLocationPin)
            NotificationButton(
              onTap: _toggleNotifications,
            ),

          // Notifications Panel
          if (_showNotifications && !_showLocationPin)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeNotifications,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 80, 10, 0),
                      child: NotificationsPanel(
                        onClose: _closeNotifications,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Draggable Bottom Sheet for Destination Selection
          if (_showBottomSheet)
            DraggableScrollableSheet(
              controller: _bottomSheetController,
              initialChildSize: 0.13,
              minChildSize: 0.13,
              maxChildSize: 0.85,
              snap: true,
              snapSizes: const [0.13, 0.5, 0.85],
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: DestinationBottomSheet(
                    scrollController: scrollController,
                    onLocationSelected: _onLocationSelected,
                    onLocationPinTap: _showLocationPinSheet,
                  ),
                );
              },
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}