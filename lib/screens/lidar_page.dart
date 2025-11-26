import 'package:flutter/material.dart';
import 'package:apkrover/widgets/lidar_canvas.dart';
import 'package:apkrover/services/lidar_service.dart';

class LidarPage extends StatelessWidget {
  const LidarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lidarService = LidarService();

    return Scaffold(
      appBar: AppBar(title: const Text("LIDAR Mini-map (Dummy Scan)")),
      backgroundColor: Colors.black,
      body: Center(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: lidarService.roverScanStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    "Mensimulasikan scan rover...",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              );
            }

            final points = snapshot.data!;

            return SizedBox(
              width: 300,
              height: 300,
              child: LidarCanvas(points: points),
            );
          },
        ),
      ),
    );
  }
}
