import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ArahPage extends StatefulWidget {
  const ArahPage({super.key});

  @override
  State<ArahPage> createState() => _ArahPageState();
}

class _ArahPageState extends State<ArahPage> {
  String arah = "MAJU"; // default
  late Timer timer;

  final List<String> arahList = ["MAJU", "MUNDUR", "KIRI", "KANAN", "DIAM"];

  @override
  void initState() {
    super.initState();
    // Simulasi data arah secara acak
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      setState(() {
        arah = arahList[Random().nextInt(arahList.length)];
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  IconData getArahIcon(String arah) {
    switch (arah) {
      case "MAJU":
        return Icons.arrow_upward;
      case "MUNDUR":
        return Icons.arrow_downward;
      case "KIRI":
        return Icons.arrow_back;
      case "KANAN":
        return Icons.arrow_forward;
      default:
        return Icons.stop_circle_outlined;
    }
  }

  Color getArahColor(String arah) {
    switch (arah) {
      case "MAJU":
        return Colors.greenAccent;
      case "MUNDUR":
        return Colors.orangeAccent;
      case "KIRI":
        return Colors.lightBlueAccent;
      case "KANAN":
        return Colors.purpleAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[400],
        title: const Text(
          'Arah Gerak R.O.V.E.R',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: getArahColor(arah).withOpacity(0.2),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: getArahColor(arah).withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(getArahIcon(arah), size: 100, color: getArahColor(arah)),
              const SizedBox(height: 30),
              Text(
                arah,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: getArahColor(arah),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Status arah gerak rover saat ini",
                style: TextStyle(fontSize: 16, color: Colors.grey[300]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
