import 'package:flutter/material.dart';
import '../widgets/iot_card.dart';
import '../widgets/iot_drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('R.O.V.E.R Monitoring')),
      drawer: const IoTDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: const [
            IoTCard(
              title: "MQTT",
              value: "Connected",
              icon: Icons.wifi,
              color: Colors.greenAccent,
            ),
            IoTCard(
              title: "Speed",
              value: "2.5 m/s",
              icon: Icons.speed,
              color: Colors.blueAccent,
            ),
            IoTCard(
              title: "Battery",
              value: "84%",
              icon: Icons.battery_full,
              color: Colors.yellowAccent,
            ),
            IoTCard(
              title: "Direction",
              value: "North-East",
              icon: Icons.navigation,
              color: Colors.purpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}
