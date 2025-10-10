import 'package:flutter/material.dart';

import 'custom_map_pin.dart';
import 'bottom_navigation.dart';
import 'orders_screen.dart';
import 'destination_bottom_sheet.dart';
import 'notification_button.dart';
import 'notifications_panel.dart';
import 'pin_selection_overlay.dart';
import 'inbox_chat_screen.dart';
import 'package:oysloe_delivery/profile/profile_screen.dart';

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
  bool _showProfile = false;
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
      _showProfile = false;
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

  void _closeProfile() {
    setState(() {
      _showProfile = false;
    });
  }

  void _onNavTap(int index) async {
    if (index == _currentNavIndex && index != 1) return;

    // Close profile if open when switching tabs
    if (_showProfile && index != 1) {
      setState(() {
        _showProfile = false;
      });
    }

    if (index == 1) {
      // Toggle profile menu
      setState(() {
        _currentNavIndex = 1;
        _showProfile = !_showProfile;
        if (_showProfile) {
          _showNotifications = false; // Close notifications when opening profile
        }
      });
      return;
    }

    if (index == 2) {
      // Set index to 2 to highlight Messages tab
      setState(() {
        _currentNavIndex = 2;
        _showProfile = false;
      });

      // Navigate to Messages/Inbox screen - route logic is now in InboxChatScreen
      final result = await Navigator.push(
        context,
        InboxChatScreen.route(),
      );

      // If user tapped another tab from Messages, handle it
      if (result != null && result is int) {
        _onNavTap(result); // Recursively call with the new index
        return;
      }

      // Reset to home when returning normally
      if (mounted) {
        setState(() {
          _currentNavIndex = 0;
          _showBottomSheet = true;
        });
      }
      return;
    }
    setState(() {
      _currentNavIndex = index;
    });

    if (index == 0) {
      _showLocationBottomSheet();
    } else if (index == 3) {
      // Navigate to Orders screen
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OrdersScreen(),
        ),
      );

      // If user tapped another tab from Orders, handle it
      if (result != null && result is int) {
        _onNavTap(result); // Recursively call with the new index
        return;
      }

      // Reset to home when returning normally
      if (mounted) {
        setState(() {
          _currentNavIndex = 0;
          _showBottomSheet = true;
        });
      }
    }
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

          // Profile Panel (positioned to sit above bottom nav)
          if (_showProfile)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0, // Align with bottom nav height
              child: ProfileScreen(
                onClose: _closeProfile,
              ),
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