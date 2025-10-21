import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late final WebViewController _frontCamController;
  late final WebViewController _backCamController;

  @override
  void initState() {
    super.initState();

    _frontCamController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("http://192.168.4.100:81/stream"));

    _backCamController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("http://192.168.4.101:81/stream"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Live Camera Stream"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _cameraCard("Kamera Depan", _frontCamController),
            _cameraCard("Kamera Belakang", _backCamController),
          ],
        ),
      ),
    );
  }

  Widget _cameraCard(String title, WebViewController controller) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.videocam, color: Colors.lightBlueAccent),
            title: Text(title, style: const TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 200, child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
