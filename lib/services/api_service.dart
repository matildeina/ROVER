import 'dart:convert';
import 'package:http/http.dart' as http;

// Ganti IP sesuai device kamu
const String baseUrl = "http://10.0.2.2:5000";

class ApiService {
  Future<Map<String, dynamic>> getGps() async {
    final res = await http.get(Uri.parse("$baseUrl/gps"));
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getSpeed() async {
    final res = await http.get(Uri.parse("$baseUrl/speed"));
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getBattery() async {
    final res = await http.get(Uri.parse("$baseUrl/battery"));
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> getStatus() async {
    final res = await http.get(Uri.parse("$baseUrl/status"));
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> getLidar() async {
    final res = await http.get(Uri.parse("$baseUrl/lidar"));
    return jsonDecode(res.body);
  }
}
