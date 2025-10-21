import 'package:flutter/material.dart';
import '../screens/mqtt_status_page.dart';
import '../screens/rover_status_page.dart';
import '../screens/jarak_page.dart';
import '../screens/kecepatan_page.dart';
import '../screens/arah_page.dart';
import '../screens/baterai_page.dart';
import '../screens/about_page.dart';
import '../screens/camera_page.dart';
import '../screens/lidar_page.dart';

class IoTDrawer extends StatelessWidget {
  const IoTDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan, Colors.blueAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.precision_manufacturing,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                  'R.O.V.E.R Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(
            Icons.wifi,
            "MQTT Status",
            context,
            const MqttStatusPage(),
          ),
          _drawerItem(
            Icons.smart_toy,
            "Status Rover",
            context,
            const RoverStatusPage(),
          ),
          _drawerItem(
            Icons.route,
            "Jarak Ditempuh",
            context,
            const JarakPage(),
          ),
          _drawerItem(Icons.speed, "Kecepatan", context, const KecepatanPage()),
          _drawerItem(
            Icons.navigation,
            "Arah Gerak",
            context,
            const ArahPage(),
          ),
          _drawerItem(
            Icons.battery_full,
            "Status Baterai",
            context,
            const BateraiPage(),
          ),
          _drawerItem(
            Icons.camera_alt,
            "Live Camera",
            context,
            const CameraPage(),
          ),
          _drawerItem(
            Icons.sensors,
            "LIDAR Mini-Map",
            context,
            const LidarPage(),
          ),
          _drawerItem(
            Icons.info_outline,
            "About R.O.V.E.R",
            context,
            const AboutPage(),
          ),
        ],
      ),
    );
  }

  static ListTile _drawerItem(
    IconData icon,
    String title,
    BuildContext context,
    Widget page,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.cyanAccent),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
