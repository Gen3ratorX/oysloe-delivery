import 'package:flutter/material.dart';

class NotificationsPanel extends StatelessWidget {
  final VoidCallback onClose;

  const NotificationsPanel({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'company': 'JoSem plus company ltd',
        'courier': 'John AE Kennedy',
        'orderId': '#6754-485-45',
        'status': 'Courier assigned for order with tracking id',
        'time': '10m',
      },
      {
        'company': 'JoSem plus company ltd',
        'courier': 'John AE Kennedy',
        'orderId': '#6754-485-45',
        'status': 'picked up by your courier',
        'time': '9m',
      },
      {
        'company': 'JoSem plus company ltd',
        'courier': 'John AE Kennedy',
        'orderId': '#6754-485-45',
        'status': 'is on road to your drop of destination',
        'time': '8m',
      },
      {
        'company': 'JoSem plus company ltd',
        'courier': 'John AE Kennedy',
        'orderId': '#6754-485-45',
        'status': 'is delivered',
        'time': '7m',
      },
    ];

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Custom shaped panel
        ClipPath(
          clipper: NotificationPanelClipper(),
          child: CustomPaint(
            painter: NotificationPanelPainter(),
            child: Container(
              width: 360,
              height: 380,
              padding: const EdgeInsets.only(top: 60),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 4,
                radius: const Radius.circular(2),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 20, 24, 20),
                  itemCount: notifications.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    final company = notification['company'] as String? ?? '';
                    final courier = notification['courier'] as String? ?? '';
                    final orderId = notification['orderId'] as String? ?? '';
                    final status = notification['status'] as String? ?? '';
                    final time = notification['time'] as String? ?? '';

                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  company,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ),
                              Text(
                                time,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF999999),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF666666),
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(text: '$courier: '),
                                TextSpan(text: status),
                                TextSpan(text: ' Order with id '),
                                TextSpan(
                                  text: orderId,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // Notification bell with better positioning
        Positioned(
          top: 0,
          child: Container(
            width: 59,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF7FD4A8),
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                'assets/notification.png',
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.notifications_none,
                    size: 24,
                    color: Color(0xFF2F3C48),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NotificationPanelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeJoin = StrokeJoin.round;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
      ..style = PaintingStyle.fill;

    // Draw shadow first
    final shadowPath = Path()
      ..moveTo(25, 65)
      ..quadraticBezierTo(25, 45, 45, 45)
      ..lineTo(131, 45)
      ..quadraticBezierTo(151, 45, 151, 25)
      ..quadraticBezierTo(151, 5, 171, 5)
      ..lineTo(190, 5)
      ..quadraticBezierTo(210, 5, 210, 25)
      ..quadraticBezierTo(210, 45, 230, 45)
      ..lineTo(325, 45)
      ..quadraticBezierTo(345, 45, 345, 65)
      ..lineTo(345, 365)
      ..quadraticBezierTo(345, 385, 325, 385)
      ..lineTo(45, 385)
      ..quadraticBezierTo(25, 385, 25, 365)
      ..close();

    canvas.drawPath(shadowPath, shadowPaint);

    // Draw main shape
    final path = Path()
      ..moveTo(20, 60)
      ..quadraticBezierTo(20, 40, 40, 40)
      ..lineTo(131, 40)
      ..quadraticBezierTo(151, 40, 151, 20)
      ..quadraticBezierTo(151, 0, 171, 0)
      ..lineTo(190, 0)
      ..quadraticBezierTo(210, 0, 210, 20)
      ..quadraticBezierTo(210, 40, 230, 40)
      ..lineTo(320, 40)
      ..quadraticBezierTo(340, 40, 340, 60)
      ..lineTo(340, 360)
      ..quadraticBezierTo(340, 380, 320, 380)
      ..lineTo(40, 380)
      ..quadraticBezierTo(20, 380, 20, 360)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NotificationPanelClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(20, 60)
      ..quadraticBezierTo(20, 40, 40, 40)
      ..lineTo(131, 40)
      ..quadraticBezierTo(151, 40, 151, 20)
      ..quadraticBezierTo(151, 0, 171, 0)
      ..lineTo(190, 0)
      ..quadraticBezierTo(210, 0, 210, 20)
      ..quadraticBezierTo(210, 40, 230, 40)
      ..lineTo(320, 40)
      ..quadraticBezierTo(340, 40, 340, 60)
      ..lineTo(340, 360)
      ..quadraticBezierTo(340, 380, 320, 380)
      ..lineTo(40, 380)
      ..quadraticBezierTo(20, 380, 20, 360)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}