import 'package:flutter/material.dart';
import 'delete_account_dialog.dart';
import 'logout_dialog.dart';
import 'package:oysloe_delivery/auth/login_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';
import 'feedback_screen.dart';


class ProfileScreen extends StatelessWidget {
  final VoidCallback? onClose;

  const ProfileScreen({
    super.key,
    this.onClose,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const DeleteAccountDialog();
      },
    ).then((result) {
      if (result == true) {
        // Handle account deletion confirmed
        print('Account deletion confirmed');
        // Add your account deletion logic here
      }
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const LogoutDialog();
      },
    ).then((result) {
      if (result == true) {
        // Handle logout confirmed - navigate to login screen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
              (route) => false, // Remove all previous routes
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded gesture detector for dismissing (excludes bottom nav area)
        Expanded(
          child: GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {}, // Prevent tap from closing when tapping menu
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 0),
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
                            onTap: () {
                              onClose?.call(); // Close profile menu first
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FeedbackScreen(),
                                ),
                              );
                            },
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
                            onTap: () => _showDeleteDialog(context),
                          ),
                          _buildMenuItem(
                            imagePath: 'assets/terms.png',
                            title: 'T&C',
                            onTap: () {
                              onClose?.call(); // Close profile menu first
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TermsConditionsScreen(),
                                ),
                              );
                            },
                          ),
                          _buildMenuItem(
                            imagePath: 'assets/private.png',
                            title: 'Privacy policy',
                            onTap: () {
                              onClose?.call(); // Close profile menu first
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicyScreen(),
                                ),
                              );
                            },
                          ),
                          _buildMenuItem(
                            imagePath: 'assets/log.png',
                            title: 'Logout',
                            onTap: () => _showLogoutDialog(context),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Empty space for bottom navigation (allows taps to pass through)
        const SizedBox(height: 0),
      ],
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