import 'package:flutter/material.dart';
//import 'package:apkrover/services/lidar_service.dart';

class RoverStatusPage extends StatefulWidget {
  const RoverStatusPage({super.key});

  @override
  State<RoverStatusPage> createState() => _RoverStatusPageState();
}

class _RoverStatusPageState extends State<RoverStatusPage> {
  //late LidarService _lidarService;
  bool _isRoverOn = false; // false = mati, true = menyala

  @override
  void initState() {
    super.initState();
    //_lidarService = LidarService();
    _checkRoverStatus();
  }

  @override
  void dispose() {
    //_lidarService.dispose();
    super.dispose();
  }

  // Fungsi simulasi untuk mengecek status rover
  void _checkRoverStatus() async {
    // Simulasikan proses cek status (bisa diganti dari API, MQTT, dsb)
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isRoverOn = true; // ubah sesuai kondisi sebenarnya
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Status Rover"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Card(
          color: Colors.blueGrey[800],
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isRoverOn ? Icons.power : Icons.power_off,
                  color: _isRoverOn ? Colors.greenAccent : Colors.redAccent,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  _isRoverOn ? "Rover Menyala" : "Rover Mati",
                  style: TextStyle(
                    color: _isRoverOn ? Colors.greenAccent : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _isRoverOn
                      ? "Sistem rover aktif dan siap digunakan."
                      : "Rover dalam keadaan tidak aktif.",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _checkRoverStatus,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Perbarui Status"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
