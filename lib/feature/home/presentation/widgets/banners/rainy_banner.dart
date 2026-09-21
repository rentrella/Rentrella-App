import 'package:flutter/material.dart';

class RainyBanner extends StatefulWidget {
  const RainyBanner();

  @override
  State<RainyBanner> createState() => _RainyBannerState();
}

class _RainyBannerState extends State<RainyBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) =>
          CustomPaint(painter: _RainyPainter(_controller.value)),
    );
  }
}

class _RainyPainter extends CustomPainter {
  const _RainyPainter(this.t);

  final double t;

  static const _bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7DB8E8), Color(0xFF5B9BD5), Color(0xFF4A87C7)],
    stops: [0.0, 0.4, 1.0],
  );

  // (columnX, startPhase, dropLength)
  static const _drops = <(double, double, double)>[
    (0.03, 0.00, 0.13), (0.09, 0.62, 0.10), (0.15, 0.28, 0.14),
    (0.21, 0.80, 0.11), (0.27, 0.14, 0.12), (0.33, 0.50, 0.15),
    (0.39, 0.72, 0.10), (0.45, 0.24, 0.13), (0.51, 0.90, 0.11),
    (0.57, 0.38, 0.12), (0.63, 0.06, 0.14), (0.69, 0.55, 0.10),
    (0.75, 0.76, 0.12), (0.81, 0.34, 0.11), (0.87, 0.18, 0.13),
    (0.93, 0.64, 0.10), (0.06, 0.44, 0.11), (0.12, 0.86, 0.14),
    (0.18, 0.10, 0.12), (0.24, 0.56, 0.10), (0.30, 0.32, 0.15),
    (0.36, 0.74, 0.11), (0.42, 0.04, 0.12), (0.48, 0.48, 0.13),
    (0.54, 0.22, 0.10), (0.60, 0.66, 0.12), (0.66, 0.42, 0.11),
    (0.72, 0.84, 0.13), (0.78, 0.16, 0.10), (0.84, 0.58, 0.12),
    (0.90, 0.36, 0.14), (0.96, 0.78, 0.11),
  ];

  static const _sinA = 0.292; // sin(17°)
  static const _cosA = 0.956; // cos(17°)

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..shader = _bg.createShader(rect));
    _drawCloudMass(canvas, size);
    _drawRain(canvas, size);
  }

  void _drawCloudMass(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.50, -size.height * 0.20),
        width: size.width * 1.30,
        height: size.height * 0.72,
      ),
      Paint()
        ..color = const Color.fromRGBO(55, 88, 140, 0.34)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 26),
    );
  }

  void _drawRain(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final (bx, phase, rl) in _drops) {
      final relY = (phase + t) % 1.0;
      final x = bx * size.width;
      final y = relY * size.height;
      final len = rl * size.height;

      double alpha = 0.55;
      if (relY < 0.06) alpha *= relY / 0.06;
      if (relY > 0.86) alpha *= (1.0 - relY) / 0.14;

      canvas.drawLine(
        Offset(x, y),
        Offset(x - _sinA * len, y + _cosA * len),
        paint..color = Color.fromRGBO(255, 255, 255, alpha.clamp(0.0, 0.55)),
      );
    }
  }

  @override
  bool shouldRepaint(_RainyPainter old) => old.t != t;
}
