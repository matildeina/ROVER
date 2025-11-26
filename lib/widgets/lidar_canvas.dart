import 'package:flutter/material.dart';
import 'dart:math';

class LidarCanvas extends StatelessWidget {
  final List<Map<String, dynamic>> points;

  const LidarCanvas({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LidarPainter(points),
      size: const Size(300, 300),
    );
  }
}

class LidarPainter extends CustomPainter {
  List<Map<String, dynamic>> points;

  LidarPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.blue;

    for (var p in points) {
      double angle = p["angle"] * pi / 180;
      double distance = p["distance"] / 2; // scaling

      final x = center.dx + distance * cos(angle);
      final y = center.dy + distance * sin(angle);

      canvas.drawCircle(Offset(x, y), 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
