import 'dart:async';
import 'dart:math';

class LidarService {
  /// Stream data LIDAR dummy yang terus mengalir
  Stream<List<Map<String, dynamic>>> roverScanStream() async* {
    final random = Random();
    int step = 0;

    while (true) {
      final List<Map<String, dynamic>> points = [];

      // 0..360 derajat, tiap 2 derajat satu titik
      for (int angle = 0; angle < 360; angle += 2) {
        double dist;

        // --- Bentuk dasar: ruangan / lorong ---
        final a = angle <= 180 ? angle.toDouble() : (360 - angle).toDouble();

        if (a < 25) {
          dist = 80.0;
        } else if (a < 60) {
          dist = 130.0;
        } else {
          dist = 200.0;
        }

        // --- Halangan bergerak (seakan rover jalan) ---
        final obstacleCenter = (step * 5) % 360;
        int diff = (angle - obstacleCenter);
        if (diff < 0) diff += 360;
        if (diff > 180) diff = 360 - diff;

        if (diff < 8) {
          // dekat obstacle → jarak lebih pendek
          dist = 40.0 + random.nextInt(20).toDouble(); // 40–60
        } else {
          // noise kecil biar hidup
          dist += (random.nextInt(15) - 7).toDouble(); // ±7
        }

        // clamp jarak
        if (dist < 20.0) dist = 20.0;
        if (dist > 250.0) dist = 250.0;

        points.add({'angle': angle.toDouble(), 'distance': dist});
      }

      yield points;

      await Future.delayed(const Duration(milliseconds: 120));
      step++;
    }
  }
}
