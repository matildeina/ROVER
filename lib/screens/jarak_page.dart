import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class JarakPage extends StatefulWidget {
  const JarakPage({super.key});

  @override
  State<JarakPage> createState() => _JarakPageState();
}

class _JarakPageState extends State<JarakPage> {
  double jarak = 0; // dalam meter
  double kecepatan = 0.0; // m/s
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Simulasi jarak bertambah tiap detik
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      setState(() {
        kecepatan = (Random().nextDouble() * 2) + 0.5; // 0.5–2.5 m/s
        jarak += kecepatan * 2; // jarak = v * t (2 detik)
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatJarak(double meter) {
    if (meter >= 1000) {
      return "${(meter / 1000).toStringAsFixed(2)} km";
    } else {
      return "${meter.toStringAsFixed(1)} m";
    }
  }

  Color getColor(double kecepatan) {
    if (kecepatan < 1) return Colors.greenAccent;
    if (kecepatan < 2) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[400],
        title: const Text(
          'Jarak Ditempuh R.O.V.E.R',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: getColor(kecepatan).withOpacity(0.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: getColor(kecepatan).withOpacity(0.6),
                      blurRadius: 30,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.route_rounded,
                  size: 100,
                  color: getColor(kecepatan),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                formatJarak(jarak),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent[100],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Total jarak yang telah ditempuh",
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
              ),
              const SizedBox(height: 30),
              Text(
                "Kecepatan Saat Ini",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                "${kecepatan.toStringAsFixed(2)} m/s",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: getColor(kecepatan),
                ),
              ),
              const SizedBox(height: 30),
              LinearProgressIndicator(
                value: (kecepatan / 3).clamp(0.0, 1.0),
                backgroundColor: Colors.grey[800],
                color: getColor(kecepatan),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 20),
              Text(
                kecepatan < 1
                    ? "Rover Bergerak Lambat"
                    : (kecepatan < 2
                          ? "Rover Melaju Stabil"
                          : "Rover Bergerak Cepat!"),
                style: TextStyle(color: getColor(kecepatan), fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
