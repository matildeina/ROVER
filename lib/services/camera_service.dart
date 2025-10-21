import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Kelas ini mengatur streaming dari kamera depan dan belakang.
/// Kamu bisa mengganti URL stream sesuai dengan IP camera kamu
/// (misal: http://192.168.4.100:81/stream untuk ESP32-CAM).

class CameraService {
  static const String frontCameraUrl = "http://192.168.4.100:81/stream";
  static const String backCameraUrl = "http://192.168.4.101:81/stream";
}

/// Widget untuk menampilkan stream kamera depan atau belakang.
class CameraStream extends StatefulWidget {
  final String url;
  final String title;

  const CameraStream({Key? key, required this.url, required this.title})
    : super(key: key);

  @override
  State<CameraStream> createState() => _CameraStreamState();
}

class _CameraStreamState extends State<CameraStream> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.videocam, color: Colors.lightBlueAccent),
            title: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: VideoPlayer(_controller),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    color: Colors.lightBlueAccent,
                  ),
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
