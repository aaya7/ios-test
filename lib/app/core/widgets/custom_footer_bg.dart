import 'package:flutter/material.dart';

class FooterCustom extends StatelessWidget {
  const FooterCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShadowPainter(),
      child: Image.asset(
        "assets/images/Subtract.png",
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}

class ShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final shadowPath = Path()..addRect(rect);

    final shadowPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2) // Shadow color
      ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal, 10); // Blur radius of the shadow

    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
