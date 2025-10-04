import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Function(int)? onNavTap;

  const ProfileScreen({
    super.key,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {}, // Prevent tap from closing when tapping menu
            child: Container(
              margin: const EdgeInsets.only(bottom: 80), // Position above bottom nav
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    _buildMenuItem(
                      imagePath: 'assets/feed.png',
                      title: 'Feedback',
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade300,
                      indent: 24,
                      endIndent: 24,
                    ),
                    _buildMenuItem(
                      imagePath: 'assets/delete.png',
                      title: 'Delete',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      imagePath: 'assets/terms.png',
                      title: 'T&C',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      imagePath: 'assets/private.png',
                      title: 'Privacy policy',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      imagePath: 'assets/log.png',
                      title: 'Logout',
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 24,
                      color: Colors.grey.shade400,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}