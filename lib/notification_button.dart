import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback? onTap;

  const NotificationButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 49,
              height: 41,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/notification.png',
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.notifications_outlined,
                    color: const Color(0xFF2F3C48),
                    size: 22,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}