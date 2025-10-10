import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class CourierSelectionScreen extends StatefulWidget {
  const CourierSelectionScreen({super.key});

  @override
  State<CourierSelectionScreen> createState() => _CourierSelectionScreenState();
}

class _CourierSelectionScreenState extends State<CourierSelectionScreen> {
  int _currentNavIndex = 3; // Orders tab
  String _selectedCourier = 'Bike'; // Default selection
  String _selectedPriority = 'Xpress'; // Default selection
  final TextEditingController _instructionsController = TextEditingController();

  final List<Map<String, dynamic>> _couriers = [
    {
      'name': 'Bike',
      'description': 'Best for small parcels,up to 10kg',
      'price': 25,
      'icon': Icons.pedal_bike,
    },
    {
      'name': 'Salon Car',
      'description': 'Fragile and medium packages,up to 50 kg',
      'price': 25,
      'icon': Icons.directions_car,
    },
    {
      'name': 'Van',
      'description': 'Ideal for bulk goods,heavy loads,up to 500 kg',
      'price': 25,
      'icon': Icons.local_shipping,
    },
  ];

  void _onNavTap(int index) {
    if (index != _currentNavIndex) {
      Navigator.pop(context);
    }
  }

  int _calculateTotal() {
    int courierPrice = 25;
    int priorityPrice = _selectedPriority == 'Xpress' ? 25 : 0;
    return courierPrice + priorityPrice;
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          // Top handle
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Title
                Text(
                  'Select a courier',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),

                // Courier options
                ..._couriers.map((courier) => _buildCourierOption(courier)),

                const SizedBox(height: 20),

                // Priority section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Priority',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '00:24:00',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildPriorityButton('Xpress'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildPriorityButton('Regular'),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '+ ₵ 25/km',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Instructions input
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _instructionsController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Add address details and delivery instruction',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Order button with price
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Price
                  Text(
                    '₵ ${_calculateTotal()}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Order button
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCC80),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            // Handle order
                          },
                          borderRadius: BorderRadius.circular(28),
                          child: Center(
                            child: Text(
                              'Order',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation
          BottomNavigation(
            currentIndex: _currentNavIndex,
            onTap: _onNavTap,
          ),
        ],
      ),
    );
  }

  Widget _buildCourierOption(Map<String, dynamic> courier) {
    final bool isSelected = _selectedCourier == courier['name'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCourier = courier['name'];
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFCC80) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                courier['icon'],
                size: 32,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courier['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    courier['description'],
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Price
            Text(
              '₵ ${courier['price']}/km',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityButton(String priority) {
    final bool isSelected = _selectedPriority == priority;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPriority = priority;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFCC80) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFCC80) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            priority,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.grey.shade800 : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}