import 'package:flutter/material.dart';
import 'package:apkrover/services/gps_service.dart';

class GPSPage extends StatefulWidget {
  @override
  State<GPSPage> createState() => _GPSPageState();
}

class _GPSPageState extends State<GPSPage> {
  double? lat;
  double? lon;

  @override
  void initState() {
    super.initState();
    loadGPS();
  }

  void loadGPS() async {
    var data = await GPSService().getGPS();
    if (data != null) {
      setState(() {
        lat = data.latitude;
        lon = data.longitude;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GPS Monitoring")),
      body: Center(
        child: lat == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Latitude : $lat", style: const TextStyle(fontSize: 20)),
                  Text("Longitude: $lon", style: const TextStyle(fontSize: 20)),
                ],
              ),
      ),
    );
  }
}
