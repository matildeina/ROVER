import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("About R.O.V.E.R"),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "R.O.V.E.R (Robotic Observation Vehicle for Environmental Research)",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "R.O.V.E.R adalah kendaraan robotik berbasis IoT yang dirancang untuk "
              "melakukan pemantauan lingkungan secara real-time. "
              "Sistem ini menggabungkan teknologi sensor, kamera, dan komunikasi MQTT "
              "untuk memantau kondisi lapangan dengan efisien.",
              style: TextStyle(color: Colors.white70, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 25),
            const Text(
              "⚙️ Fitur Utama:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _featureItem(
              "Live Stream dari kamera depan & belakang (ESP32-CAM)",
            ),
            _featureItem("Mini map berbasis sensor LIDAR"),
            _featureItem("Monitoring kecepatan, arah, dan jarak tempuh"),
            _featureItem("Status baterai real-time"),
            _featureItem("Koneksi MQTT untuk komunikasi data dua arah"),
            const SizedBox(height: 25),
            const Divider(color: Colors.cyanAccent, thickness: 1),
            const SizedBox(height: 15),
            const Text(
              "💡 Tentang Pengembang:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Aplikasi ini dikembangkan oleh tim mahasiswa Informatika ITENAS Bandung "
              "sebagai bagian dari proyek sistem monitoring berbasis Internet of Things (IoT).",
              style: TextStyle(color: Colors.white70, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: const [
                  Icon(
                    Icons.precision_manufacturing,
                    color: Colors.cyanAccent,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "R.O.V.E.R Dashboard v2.0",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget kecil untuk menampilkan fitur
  Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.cyanAccent,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
