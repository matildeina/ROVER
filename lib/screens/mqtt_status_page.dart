import 'package:flutter/material.dart';

class MqttStatusPage extends StatelessWidget {
  const MqttStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("MQTT Status")),
      body: const Center(
        child: Text(
          "Connected to MQTT Broker",
          style: TextStyle(color: Colors.cyanAccent, fontSize: 18),
        ),
      ),
    );
  }
}
