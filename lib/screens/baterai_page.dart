import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class BateraiPage extends StatefulWidget {
  const BateraiPage({super.key});

  @override
  State<BateraiPage> createState() => _BateraiPageState();
}

class _BateraiPageState extends State<BateraiPage> {
  double levelBaterai = 100; // mulai dari penuh
  late Timer timer;
  bool sedangMengisi = false;

  @override
  void initState() {
    super.initState();
    // Simulasi penurunan daya dan pengisian ulang otomatis
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      setState(() {
        if (sedangMengisi) {
          levelBaterai += 5;
          if (levelBaterai >= 100) {
            levelBaterai = 100;
            sedangMengisi = false;
          }
        } else {
          levelBaterai -= Random().nextInt(6) + 1; // acak 1–6%
          if (levelBaterai <= 15) sedangMengisi = true;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Color getBatteryColor(double level) {
    if (level > 60) return Colors.greenAccent;
    if (level > 30) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  IconData getBatteryIcon(double level) {
    if (sedangMengisi) return Icons.battery_charging_full_rounded;
    if (level > 80) return Icons.battery_full_rounded;
    if (level > 60) return Icons.battery_6_bar_rounded;
    if (level > 40) return Icons.battery_5_bar_rounded;
    if (level > 20) return Icons.battery_3_bar_rounded;
    return Icons.battery_alert_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[400],
        title: const Text(
          'Status Baterai R.O.V.E.R',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: getBatteryColor(levelBaterai).withOpacity(0.15),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: getBatteryColor(levelBaterai).withOpacity(0.6),
                    blurRadius: 25,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                getBatteryIcon(levelBaterai),
                size: 100,
                color: getBatteryColor(levelBaterai),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              '${levelBaterai.toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: getBatteryColor(levelBaterai),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              sedangMengisi
                  ? "Mengisi Daya..."
                  : (levelBaterai <= 15 ? "Baterai Lemah!" : "Normal"),
              style: TextStyle(
                fontSize: 18,
                color: sedangMengisi
                    ? Colors.tealAccent
                    : (levelBaterai <= 15 ? Colors.redAccent : Colors.white70),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: LinearProgressIndicator(
                value: levelBaterai / 100,
                backgroundColor: Colors.grey[800],
                color: getBatteryColor(levelBaterai),
                minHeight: 15,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
