import 'package:flutter/material.dart';

class CustomMapPin extends StatefulWidget {
  final bool isActive;

  const CustomMapPin({
    super.key,
    this.isActive = false,
  });

  @override
  State<CustomMapPin> createState() => _CustomMapPinState();
}

class _CustomMapPinState extends State<CustomMapPin>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isActive) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(CustomMapPin oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _animationController.repeat();
    } else if (!widget.isActive && oldWidget.isActive) {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double baseWidth = 40;
    const double baseHeight = 55;
    const double activeWidth = 45;
    const double activeHeight = 60;

    return SizedBox(
      width: widget.isActive ? activeWidth : baseWidth,
      height: widget.isActive ? activeHeight : baseHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Pulsing animation when active
          if (widget.isActive)
            Positioned(
              top: 6,
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 30 + (_pulseAnimation.value * 10),
                    height: 30 + (_pulseAnimation.value * 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1976D2)
                            .withOpacity(0.4 - (_pulseAnimation.value * 0.4)),
                        width: 1.2,
                      ),
                    ),
                  );
                },
              ),
            ),

          // Pin image
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Image.asset(
                'assets/map_pin.png',
                width: widget.isActive ? activeWidth : baseWidth,
                height: widget.isActive ? activeHeight : baseHeight,
                fit: BoxFit.contain,
                color: widget.isActive
                    ? const Color(0xFF1976D2)
                    : const Color(0xFF2F3C48),
                colorBlendMode: BlendMode.srcIn,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.location_on,
                    size: widget.isActive ? activeHeight : baseHeight,
                    color: widget.isActive
                        ? const Color(0xFF1976D2)
                        : const Color(0xFF2F3C48),
                  );
                },
              ),
            ),
          ),

          // Profile image (27x27) slightly lowered
          Positioned(
            top: widget.isActive ? 8 : 7, // pushes it slightly down
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: widget.isActive ? 1.5 : 1.2,
                ),
                boxShadow: widget.isActive
                    ? [
                  BoxShadow(
                    color: const Color(0xFF1976D2).withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
                    : null,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/pin_image.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 14,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Blue border ring when active
          if (widget.isActive)
            Positioned(
              top: 8,
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF1976D2),
                    width: 1.2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
