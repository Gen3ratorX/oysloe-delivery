import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            index: 0,
            activeImage: 'assets/home_act.png',
            inactiveImage: 'assets/home_in.png',
            label: 'Home',
          ),
          _buildNavItem(
            index: 1,
            activeImage: 'assets/profile_act.png',
            inactiveImage: 'assets/profile_in.png',
            label: 'Profile',
          ),
          _buildNavItem(
            index: 2,
            activeImage: 'assets/message_act.png',
            inactiveImage: 'assets/message_in.png',
            label: 'Messages',
          ),
          _buildNavItem(
            index: 3,
            activeImage: 'assets/order_act.png',
            inactiveImage: 'assets/order_in.png',
            label: 'Orders',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String activeImage,
    required String inactiveImage,
    required String label,
  }) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            isActive ? activeImage : inactiveImage,
            width: 24,
            height: 24,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.error_outline,
                size: 24,
                color: Colors.grey.shade400,
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.grey.shade800 : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}