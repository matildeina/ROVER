import 'package:flutter/material.dart';

// Import semua page
import 'screens/mqtt_status_page.dart';
import 'screens/rover_status_page.dart';
import 'screens/jarak_page.dart';
import 'screens/kecepatan_page.dart';
import 'screens/arah_page.dart';
import 'screens/baterai_page.dart';
import 'screens/camera_page.dart';
import 'screens/lidar_page.dart';
import 'screens/gps_page.dart';
import 'screens/about_page.dart';

// Drawer
import 'widgets/iot_drawer.dart';

void main() {
  runApp(const RoverApp());
}

class RoverApp extends StatelessWidget {
  const RoverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ROVER Monitoring",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const IoTDrawer(),
      appBar: AppBar(
        title: const Text("R.O.V.E.R Dashboard"),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.black,
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _menuCard(context, Icons.map, "GPS", GPSPage()),
          _menuCard(context, Icons.sensors, "LIDAR", LidarPage()),
          _menuCard(
            context,
            Icons.smart_toy,
            "Status Rover",
            RoverStatusPage(),
          ),
          _menuCard(context, Icons.wifi, "MQTT Status", MqttStatusPage()),
          _menuCard(context, Icons.speed, "Kecepatan", KecepatanPage()),
          _menuCard(context, Icons.route, "Jarak", JarakPage()),
          _menuCard(context, Icons.navigation, "Arah", ArahPage()),
          _menuCard(context, Icons.battery_full, "Baterai", BateraiPage()),
          _menuCard(context, Icons.camera_alt, "Camera", CameraPage()),
          _menuCard(context, Icons.info_outline, "About", AboutPage()),
        ],
      ),
    );
  }

  Widget _menuCard(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.cyanAccent),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
