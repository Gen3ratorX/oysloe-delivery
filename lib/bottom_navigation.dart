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
          GestureDetector(
            onTap: () => onTap(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: currentIndex == 0 ? Colors.grey.shade800 : Colors.grey.shade400,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 12,
                    color: currentIndex == 0 ? Colors.grey.shade800 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onTap(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  color: currentIndex == 1 ? Colors.grey.shade800 : Colors.grey.shade400,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 12,
                    color: currentIndex == 1 ? Colors.grey.shade800 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onTap(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message_outlined,
                  color: currentIndex == 2 ? Colors.grey.shade800 : Colors.grey.shade400,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 12,
                    color: currentIndex == 2 ? Colors.grey.shade800 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onTap(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: currentIndex == 3 ? Colors.grey.shade800 : Colors.grey.shade400,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 12,
                    color: currentIndex == 3 ? Colors.grey.shade800 : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}