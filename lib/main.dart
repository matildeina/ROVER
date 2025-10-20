import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(const RoverApp());
}

class RoverApp extends StatelessWidget {
  const RoverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'R.O.V.E.R Monitoring',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primaryColor: const Color(0xFFE50914),
      ),
      debugShowCheckedModeBanner: false,
      home: const RoverDashboard(),
    );
  }
}

class RoverDashboard extends StatefulWidget {
  const RoverDashboard({super.key});

  @override
  State<RoverDashboard> createState() => _RoverDashboardState();
}

class _RoverDashboardState extends State<RoverDashboard> {
  double _distance = 0.0;
  double _speed = 0.0;
  double _battery = 100.0;
  String _direction = "Diam";
  String _statusRover = "Nonaktif ❌";
  String _mqttStatus = "Disconnected ❌";
  late Timer _timer;
  final Random _random = Random();
  late MqttServerClient client;

  @override
  void initState() {
    super.initState();

    // Jalankan simulasi data realtime
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _distance += _random.nextDouble() * 0.2;
        _speed = _random.nextDouble() * 6;
        _direction = [
          "Maju",
          "Mundur",
          "Kiri",
          "Kanan",
          "Diam",
        ][_random.nextInt(5)];
        _battery = max(0, _battery - _random.nextDouble() * 0.3);
        _statusRover = _speed > 0.2 ? "Aktif ✅" : "Nonaktif ❌";
      });
    });

    _connectMQTT();
  }

  // === Koneksi MQTT ===
  Future<void> _connectMQTT() async {
    client = MqttServerClient.withPort(
      'broker.hivemq.com',
      'flutter_rover_${DateTime.now().millisecondsSinceEpoch}',
      8000,
    );

    client.useWebSocket = true;
    client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;
    client.keepAlivePeriod = 20;

    client.onConnected = () {
      setState(() => _mqttStatus = "Connected ✅");
      client.subscribe('rover/control', MqttQos.atMostOnce);
    };

    client.onDisconnected = () {
      setState(() => _mqttStatus = "Disconnected ❌");
    };

    final connMess = MqttConnectMessage()
        .withClientIdentifier('flutter_rover_${Random().nextInt(9999)}')
        .startClean()
        .withWillTopic('rover/status')
        .withWillMessage('Offline')
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMess;

    try {
      await client.connect();
    } catch (e) {
      client.disconnect();
    }

    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
        final String message = MqttPublishPayload.bytesToStringAsString(
          recMess.payload.message,
        );

        setState(() {
          _direction = message;
        });
      });
    } else {
      setState(() => _mqttStatus = "Disconnected ❌");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    client.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("R.O.V.E.R Realtime Monitoring"),
        centerTitle: true,
        backgroundColor: const Color(0xFFE50914),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // === LIVE STREAM DEPAN & BELAKANG ===
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cameraBox("Depan", "https://i.imgur.com/9YjKQ5O.jpg"),
                _cameraBox("Belakang", "https://i.imgur.com/Ms7HsXb.jpeg"),
              ],
            ),
            const SizedBox(height: 20),

            // === MINI MAP LIDAR (dummy) ===
            _lidarMap(),

            const SizedBox(height: 20),

            // === STATUS MQTT & ROVER ===
            _statusTile(
              "MQTT Status",
              _mqttStatus,
              _mqttStatus.contains("Connected") ? Colors.green : Colors.red,
            ),
            _statusTile(
              "Status Rover",
              _statusRover,
              _statusRover.contains("Aktif") ? Colors.green : Colors.red,
            ),

            const SizedBox(height: 10),

            // === DATA MONITORING ===
            _dataTile(
              "Jarak Ditempuh",
              "${_distance.toStringAsFixed(2)} km",
              Icons.route,
            ),
            _dataTile(
              "Kecepatan",
              "${_speed.toStringAsFixed(1)} km/h",
              Icons.speed,
            ),
            _dataTile("Arah Gerak", _direction, Icons.directions_car),

            // === STATUS BATERAI ===
            _batteryTile(),

            const SizedBox(height: 20),

            // === ABOUT ROVER (klik ke halaman baru) ===
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutRoverPage(),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.redAccent),
                  title: Text("About R.O.V.E.R"),
                  subtitle: Text("Klik untuk melihat informasi lebih lanjut"),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Widget Kamera ===
  Widget _cameraBox(String label, String imageUrl) {
    return Expanded(
      child: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.redAccent, width: 2),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            color: Colors.black54,
            padding: const EdgeInsets.all(4),
            child: Text(
              'Live $label',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // === Widget Mini Map LIDAR ===
  Widget _lidarMap() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomPaint(painter: LidarPainter()),
    );
  }

  // === Widget Status ===
  Widget _statusTile(String title, String value, Color color) {
    return ListTile(
      leading: Icon(Icons.info, color: color),
      title: Text(title),
      trailing: Text(
        value,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  // === Widget Data Monitoring ===
  Widget _dataTile(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.redAccent),
        title: Text(title),
        trailing: Text(value),
      ),
    );
  }

  // === Widget Baterai ===
  Widget _batteryTile() {
    return ListTile(
      leading: const Icon(Icons.battery_full, color: Colors.redAccent),
      title: const Text("Status Baterai"),
      trailing: Text("${_battery.toStringAsFixed(1)}%"),
    );
  }
}

// === Halaman About Rover ===
class AboutRoverPage extends StatelessWidget {
  const AboutRoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About R.O.V.E.R"),
        backgroundColor: const Color(0xFFE50914),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "R.O.V.E.R (Robotic Observation Vehicle for Environmental Research)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "R.O.V.E.R adalah kendaraan robotik cerdas yang dirancang untuk melakukan pemantauan lingkungan secara real-time. "
              "Sistem ini dilengkapi dengan kamera depan dan belakang, sensor LIDAR untuk pemetaan, serta berbagai sensor lingkungan "
              "seperti suhu, kelembapan, dan gas. Semua data dikirim melalui protokol MQTT untuk dianalisis secara langsung.",
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              "Fitur Utama:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text("• Live Stream dari ESP32-CAM (Depan & Belakang)"),
            Text("• Peta mini dari sensor LIDAR"),
            Text("• Pemantauan kecepatan dan arah gerak"),
            Text("• Monitoring status baterai dan kondisi rover"),
            Text("• Komunikasi MQTT Realtime"),
            SizedBox(height: 20),
            Text(
              "Dikembangkan oleh tim mahasiswa Informatika ITENAS Bandung.",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// === Visualisasi LIDAR Dummy ===
class LidarPainter extends CustomPainter {
  final Random _random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.greenAccent;
    final center = Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < 100; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final radius = _random.nextDouble() * (size.width / 2);
      final point = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawCircle(point, 2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
