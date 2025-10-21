import 'package:flutter/material.dart';
import '../services/camera_service.dart';
import '../services/lidar_service.dart';

class RoverStatusPage extends StatefulWidget {
  const RoverStatusPage({super.key});

  @override
  State<RoverStatusPage> createState() => _RoverStatusPageState();
}

class _RoverStatusPageState extends State<RoverStatusPage> {
  late LidarService _lidarService;

  @override
  void initState() {
    super.initState();
    _lidarService = LidarService();
  }

  @override
  void dispose() {
    _lidarService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Rover Live Feed & LIDAR"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CameraStream(
              url: CameraService.frontCameraUrl,
              title: "Kamera Depan",
            ),
            const CameraStream(
              url: CameraService.backCameraUrl,
              title: "Kamera Belakang",
            ),
            const SizedBox(height: 10),
            Text(
              "LIDAR Mini Map",
              style: TextStyle(
                color: Colors.lightBlueAccent.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            LidarMiniMap(lidarStream: _lidarService.lidarStream),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
