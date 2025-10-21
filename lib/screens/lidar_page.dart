import 'package:flutter/material.dart';
import 'dart:math';

class LidarPage extends StatefulWidget {
  const LidarPage({super.key});

  @override
  State<LidarPage> createState() => _LidarPageState();
}

class _LidarPageState extends State<LidarPage> {
  final List<Offset> _points = [];

  @override
  void initState() {
    super.initState();
    // Simulasi data LIDAR acak
    generateFakeLidarData();
  }

  void generateFakeLidarData() {
    final random = Random();
    for (int i = 0; i < 360; i++) {
      final distance = 100 + random.nextInt(100);
      final rad = i * pi / 180;
      _points.add(Offset(distance * cos(rad), distance * sin(rad)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("LIDAR Mini-Map")),
      body: Center(
        child: CustomPaint(
          painter: LidarPainter(_points),
          size: const Size(300, 300),
        ),
      ),
    );
  }
}

class LidarPainter extends CustomPainter {
  final List<Offset> points;
  LidarPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2;

    for (final p in points) {
      canvas.drawCircle(center + p * 0.8, 2, paint);
    }

    canvas.drawCircle(center, 4, Paint()..color = Colors.red); // Rover
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
