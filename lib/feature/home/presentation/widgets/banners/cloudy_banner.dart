import 'dart:math' as math;
import 'package:flutter/material.dart';

class CloudyBanner extends StatefulWidget {
  const CloudyBanner();

  @override
  State<CloudyBanner> createState() => _CloudyBannerState();
}

class _CloudyBannerState extends State<CloudyBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
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
          CustomPaint(painter: _CloudyPainter(_controller.value)),
    );
  }
}

class _CloudyPainter extends CustomPainter {
  const _CloudyPainter(this.t);

  final double t;

  static const _bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7AB7EC), Color(0xFF9CCDF4), Color(0xFFBFDFF6)],
    stops: [0.0, 0.48, 1.0],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..shader = _bg.createShader(rect));

    _drawCloud(canvas, size,
        baseX: 0.22, relY: 0.88, r: size.height * 0.30,
        driftAmp: 0.04, phase: 4.19, opacity: 0.22);
    _drawCloud(canvas, size,
        baseX: 0.44, relY: 0.62, r: size.height * 0.37,
        driftAmp: 0.05, phase: 2.09, opacity: 0.33);
    _drawCloud(canvas, size,
        baseX: 0.72, relY: 0.08, r: size.height * 0.46,
        driftAmp: 0.06, phase: 0.00, opacity: 0.48);
  }

  void _drawCloud(
    Canvas canvas,
    Size size, {
    required double baseX,
    required double relY,
    required double r,
    required double driftAmp,
    required double phase,
    required double opacity,
  }) {
    final cx =
        (baseX + driftAmp * math.sin(t * 2 * math.pi + phase)) * size.width;
    _paintCloud(canvas, cx, relY * size.height, r, opacity);
  }

  void _paintCloud(
      Canvas canvas, double cx, double cy, double r, double opacity) {
    final body = Paint()
      ..color = Color.fromRGBO(255, 255, 255, opacity)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.38);
    _cloudOvals(canvas, cx, cy, r, body);

    final edge = Paint()
      ..color = Color.fromRGBO(255, 255, 255, opacity * 0.28)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.05);
    _cloudOvals(canvas, cx, cy, r * 0.88, edge);
  }

  void _cloudOvals(Canvas canvas, double cx, double cy, double r, Paint paint) {
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, cy), width: r * 2.8, height: r * 1.3),
      paint,
    );
    canvas.drawCircle(Offset(cx - r * 0.75, cy - r * 0.48), r * 0.82, paint);
    canvas.drawCircle(Offset(cx - r * 0.22, cy - r * 0.72), r * 0.92, paint);
    canvas.drawCircle(Offset(cx + r * 0.48, cy - r * 0.58), r * 0.78, paint);
    canvas.drawCircle(Offset(cx + r * 0.92, cy - r * 0.32), r * 0.62, paint);
  }

  @override
  bool shouldRepaint(_CloudyPainter old) => old.t != t;
}
