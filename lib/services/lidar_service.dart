import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// Kelas ini mensimulasikan pembacaan data LIDAR.
/// Dalam implementasi nyata, data ini bisa datang dari MQTT topic
/// (misalnya: "rover/lidar") berupa list nilai jarak dalam derajat 0–360.

class LidarService {
  final StreamController<List<Offset>> _lidarStreamController =
      StreamController.broadcast();

  Stream<List<Offset>> get lidarStream => _lidarStreamController.stream;

  final Random _random = Random();

  LidarService() {
    // Simulasi update data setiap 0.5 detik
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      List<Offset> points = _generateSimulatedData();
      _lidarStreamController.add(points);
    });
  }

  // Fungsi ini membuat titik-titik acak menyerupai data LIDAR
  List<Offset> _generateSimulatedData() {
    List<Offset> points = [];
    for (int angle = 0; angle < 360; angle += 5) {
      double distance = 100 + _random.nextDouble() * 80; // range 100–180 px
      double rad = angle * pi / 180;
      points.add(Offset(distance * cos(rad), distance * sin(rad)));
    }
    return points;
  }

  void dispose() {
    _lidarStreamController.close();
  }
}

/// Widget untuk menampilkan mini-map dari data LIDAR
class LidarMiniMap extends StatelessWidget {
  final Stream<List<Offset>> lidarStream;
  final double size;

  const LidarMiniMap({Key? key, required this.lidarStream, this.size = 250})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Offset>>(
      stream: lidarStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.lightBlueAccent),
          );
        }
        final points = snapshot.data!;
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.lightBlueAccent, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: _LidarPainter(points),
            child: Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Painter untuk menggambar titik-titik LIDAR
class _LidarPainter extends CustomPainter {
  final List<Offset> points;
  _LidarPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.lightGreenAccent
      ..style = PaintingStyle.fill;

    final Offset center = Offset(size.width / 2, size.height / 2);
    for (var point in points) {
      Offset p = center + point;
      if (p.dx >= 0 && p.dx <= size.width && p.dy >= 0 && p.dy <= size.height) {
        canvas.drawCircle(p, 2, paint);
      }
    }

    // Tambahkan lingkaran jarak sebagai referensi
    final circlePaint = Paint()
      ..color = Colors.lightBlueAccent.withOpacity(0.2)
      ..style = PaintingStyle.stroke;
    for (double r = 50; r <= 150; r += 50) {
      canvas.drawCircle(center, r, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
