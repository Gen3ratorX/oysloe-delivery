import 'package:flutter/material.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _canLogout = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _canLogout = _controller.text.trim().toLowerCase() == 'logout';
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you sure you want to logout? You will need to login again to access your account.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF666666),
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'To confirm type "Logout"',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 63,
                  child: Container(
                    height: 59,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 37,
                  child: Container(
                    height: 59,
                    decoration: BoxDecoration(
                      color: _canLogout
                          ? Colors.orange.shade300
                          : const Color(0xFFCCCCCC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _canLogout
                            ? () {
                          Navigator.pop(context, true);
                        }
                            : null,
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: _canLogout
                                  ? Colors.grey.shade800
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}