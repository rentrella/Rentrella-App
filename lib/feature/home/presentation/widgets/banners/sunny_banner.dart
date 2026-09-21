import 'dart:math' as math;
import 'package:flutter/material.dart';

class SunnyBanner extends StatefulWidget {
  const SunnyBanner();

  @override
  State<SunnyBanner> createState() => _SunnyBannerState();
}

class _SunnyBannerState extends State<SunnyBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
          CustomPaint(painter: _SunnyPainter(_controller.value)),
    );
  }
}

class _SunnyPainter extends CustomPainter {
  const _SunnyPainter(this.t);

  final double t;

  static const _bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF65B9F2), Color(0xFF8BD1FF), Color(0xFFBDE9FF)],
    stops: [0.0, 0.52, 1.0],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..shader = _bg.createShader(rect));
    _drawHorizon(canvas, size);
    _drawSun(canvas, size);
  }

  void _drawSun(Canvas canvas, Size size) {
    final bob = math.sin(t * 2 * math.pi) * size.height * 0.028;
    final center = Offset(size.width * 0.774, size.height * 0.195 + bob);
    final r = size.height * 0.390;

    canvas.drawCircle(
      center, r * 2.3,
      Paint()
        ..color = const Color.fromRGBO(255, 228, 119, 0.07)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 42),
    );
    canvas.drawCircle(
      center, r * 1.65,
      Paint()
        ..color = const Color.fromRGBO(255, 228, 119, 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22),
    );
    canvas.drawCircle(
      center, r * 1.28,
      Paint()
        ..color = const Color.fromRGBO(255, 228, 119, 0.26)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );
    canvas.drawCircle(center, r, Paint()..color = const Color(0xFFFFE477));
  }

  void _drawHorizon(Canvas canvas, Size size) {
    final groundY = size.height * 0.82;
    final groundRect = Rect.fromLTRB(0, groundY, size.width, size.height);
    canvas.drawRect(
      groundRect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x284DC468), Color(0xFF38B055)],
        ).createShader(groundRect),
    );
    _drawBush(canvas, size, cx: 0.07, cy: 0.96, r: 0.13, color: const Color(0xFF3CAD58));
    _drawBush(canvas, size, cx: 0.23, cy: 0.95, r: 0.15, color: const Color(0xFF48BC64));
    _drawBush(canvas, size, cx: 0.42, cy: 0.97, r: 0.12, color: const Color(0xFF42B65E));
    _drawBush(canvas, size, cx: 0.60, cy: 0.94, r: 0.14, color: const Color(0xFF4EC26A));
    _drawBush(canvas, size, cx: 0.77, cy: 0.96, r: 0.13, color: const Color(0xFF44B860));
    _drawBush(canvas, size, cx: 0.93, cy: 0.95, r: 0.11, color: const Color(0xFF3CAD58));
  }

  void _drawBush(
    Canvas canvas,
    Size size, {
    required double cx,
    required double cy,
    required double r,
    required Color color,
  }) {
    final bx = cx * size.width;
    final by = cy * size.height;
    final hr = r * size.height;

    final paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, hr * 0.22);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(bx, by + hr * 0.20),
        width: hr * 2.4,
        height: hr * 1.5,
      ),
      paint,
    );
    canvas.drawCircle(Offset(bx - hr * 0.52, by - hr * 0.08), hr * 0.76, paint);
    canvas.drawCircle(Offset(bx + hr * 0.06, by - hr * 0.28), hr * 0.80, paint);
    canvas.drawCircle(Offset(bx + hr * 0.56, by - hr * 0.05), hr * 0.70, paint);
  }

  @override
  bool shouldRepaint(_SunnyPainter old) => old.t != t;
}
