import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class KecepatanPage extends StatefulWidget {
  const KecepatanPage({super.key});

  @override
  State<KecepatanPage> createState() => _KecepatanPageState();
}

class _KecepatanPageState extends State<KecepatanPage>
    with SingleTickerProviderStateMixin {
  double kecepatan = 0.0;
  late Timer timer;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Simulasi data kecepatan real-time
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        kecepatan = Random().nextDouble() * 10; // 0–10 km/h
      });
    });

    // Animasi untuk efek radar berputar
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Color getSpeedColor(double speed) {
    if (speed < 3) return Colors.greenAccent;
    if (speed < 7) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final color = getSpeedColor(kecepatan);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[400],
        title: const Text(
          'Kecepatan R.O.V.E.R',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // === Radar Kecepatan ===
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * pi,
                      child: CustomPaint(
                        size: const Size(200, 200),
                        painter: RadarPainter(color: color),
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    Text(
                      "${kecepatan.toStringAsFixed(1)} km/h",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: color,
                        shadows: [
                          Shadow(blurRadius: 20, color: color.withOpacity(0.8)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Kecepatan Saat Ini",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),

            // === Bar Kecepatan ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: LinearProgressIndicator(
                value: (kecepatan / 10).clamp(0.0, 1.0),
                color: color,
                backgroundColor: Colors.grey[800],
                minHeight: 14,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 20),

            // === Status Narasi ===
            Text(
              kecepatan < 3
                  ? "Rover Bergerak Perlahan"
                  : (kecepatan < 7
                        ? "Rover Melaju Stabil"
                        : "Rover Bergerak Sangat Cepat!"),
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),

            // === Info Tambahan ===
            Icon(Icons.speed_rounded, color: color, size: 60),
            const SizedBox(height: 10),
            Text(
              "Monitoring Kecepatan Realtime",
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}

// === Custom Radar Painter ===
class RadarPainter extends CustomPainter {
  final Color color;
  RadarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color.withOpacity(0.5)
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Gambar lingkaran radar
    for (int i = 1; i <= 3; i++) {
      canvas.drawCircle(center, radius * (i / 3), paint);
    }

    // Gambar garis arah
    for (int i = 0; i < 360; i += 45) {
      final rad = i * pi / 180;
      final x = center.dx + radius * cos(rad);
      final y = center.dy + radius * sin(rad);
      canvas.drawLine(center, Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
