import 'dart:math' as math;
import 'package:flutter/material.dart';

class SnowyBanner extends StatefulWidget {
  const SnowyBanner();

  @override
  State<SnowyBanner> createState() => _SnowyBannerState();
}

class _SnowyBannerState extends State<SnowyBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
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
          CustomPaint(painter: _SnowyPainter(_controller.value)),
    );
  }
}

class _SnowyPainter extends CustomPainter {
  const _SnowyPainter(this.t);

  final double t;

  static const _bg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8DB8E8), Color(0xFFB9DDFF), Color(0xFFECF7FF)],
    stops: [0.0, 0.52, 1.0],
  );

  // (baseX, startPhase, radiusRatio, driftPhase)
  static const _flakes = <(double, double, double, double)>[
    (0.05, 0.00, 0.050, 0.00), (0.12, 0.30, 0.043, 1.57),
    (0.19, 0.62, 0.064, 3.14), (0.26, 0.15, 0.035, 0.79),
    (0.33, 0.46, 0.050, 2.36), (0.40, 0.77, 0.043, 4.19),
    (0.47, 0.22, 0.064, 1.05), (0.54, 0.58, 0.035, 3.56),
    (0.61, 0.88, 0.050, 5.08), (0.68, 0.10, 0.043, 1.99),
    (0.75, 0.40, 0.064, 0.52), (0.82, 0.70, 0.035, 4.71),
    (0.89, 0.25, 0.050, 1.83), (0.96, 0.52, 0.043, 3.25),
    (0.08, 0.66, 0.064, 5.55), (0.15, 0.36, 0.035, 0.21),
    (0.22, 0.82, 0.050, 2.81), (0.29, 0.06, 0.043, 4.45),
    (0.36, 0.44, 0.064, 1.26), (0.43, 0.91, 0.035, 3.77),
    (0.50, 0.18, 0.050, 5.83), (0.57, 0.60, 0.043, 0.68),
    (0.64, 0.34, 0.064, 2.51), (0.71, 0.72, 0.035, 4.01),
    (0.78, 0.13, 0.050, 1.30), (0.85, 0.50, 0.043, 5.34),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..shader = _bg.createShader(rect));
    _drawFlakes(canvas, size);
  }

  void _drawFlakes(Canvas canvas, Size size) {
    for (final (bx, phase, rr, driftPhase) in _flakes) {
      final relY = (phase + t) % 1.0;
      final r = rr * size.height;

      final driftAmp = size.width * 0.016;
      final x = bx * size.width + driftAmp * math.sin(t * 4 * math.pi + driftPhase);
      final y = relY * size.height;

      double alpha = 0.90;
      if (relY < 0.06) alpha *= relY / 0.06;
      if (relY > 0.90) alpha *= (1.0 - relY) / 0.10;

      canvas.drawCircle(
        Offset(x, y),
        r * 1.7,
        Paint()
          ..color = Color.fromRGBO(255, 255, 255, alpha * 0.28)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.9),
      );
      canvas.drawCircle(
        Offset(x, y),
        r,
        Paint()..color = Color.fromRGBO(255, 255, 255, alpha),
      );
    }
  }

  @override
  bool shouldRepaint(_SnowyPainter old) => old.t != t;
}
