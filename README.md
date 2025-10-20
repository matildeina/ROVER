# 🛰️ R.O.V.E.R Monitoring App

**R.O.V.E.R (Real-time Observation Vehicle & Environment Rover)** adalah aplikasi berbasis **Flutter** yang digunakan untuk memantau kondisi dan pergerakan kendaraan robotik (rover) secara **realtime** menggunakan koneksi **MQTT**.  
Aplikasi ini menampilkan berbagai data penting dari rover seperti video streaming, kecepatan, arah, sensor, hingga status baterai.

## 🚀 Fitur Utama

### 🎥 Live Stream (Depan & Belakang)
Menampilkan video streaming secara langsung dari kamera **ESP32-CAM** depan dan belakang yang terpasang pada rover.

### 🗺️ Mini Map dari LiDAR
Menampilkan peta mini hasil pemetaan lingkungan menggunakan sensor **LiDAR**, sehingga pengguna dapat melihat kondisi sekitar rover secara visual.

### 📡 Monitoring Sensor
Menampilkan data dari berbagai sensor seperti:
- Sensor jarak
- Sensor suhu dan kelembapan
- Sensor gas/asap (jika ada)

### ⚡ Kecepatan & Arah Gerak
Menampilkan kecepatan rover dalam satuan km/h dan arah gerak secara realtime (maju, mundur, kiri, kanan, diam).

### 🔋 Status Baterai
Menunjukkan kapasitas daya baterai rover dalam persentase agar pengguna mengetahui kapan perlu pengisian ulang.

### 🤖 Status Rover
Menampilkan apakah rover sedang **aktif** atau **tidak aktif**, serta status koneksi ke broker MQTT.

### ℹ️ About Rover
Halaman tambahan yang berisi informasi detail tentang:
- Deskripsi singkat rover  
- Komponen utama yang digunakan  
- Fungsi tiap bagian  
- Tim pengembang (opsional)

---

## 🧩 Teknologi yang Digunakan

| Komponen | Deskripsi |
|-----------|------------|
| **Flutter** | Framework utama untuk tampilan aplikasi |
| **Dart** | Bahasa pemrograman untuk logika aplikasi |
| **MQTT (HiveMQ)** | Protokol komunikasi data antara aplikasi dan rover |
| **ESP32 / ESP32-CAM** | Mikrokontroler yang digunakan untuk kontrol dan streaming video |
| **LiDAR / Ultrasonic Sensor** | Untuk pemetaan area sekitar rover |
| **DHT11/DHT22, MQ2, dll.** | Sensor tambahan untuk monitoring lingkungan |

---

## ⚙️ Instalasi dan Menjalankan Aplikasi

1. Pastikan sudah menginstal **Flutter SDK**  
   [Panduan Instalasi Flutter](https://docs.flutter.dev/get-started/install)

2. Clone repository ini:
   ```bash
   git clone https://github.com/username/rover_monitoring.git
3. Masuk ke folder proyek:
   ```bash
   cd rover_monitoring
4. Jakankan perintah:
   ```bash
   flutter pub get
   flutter run
5. Aplikasi siap dijalankan di emulator atau perangkat fisik.

---
📱 Tampilan Utama

Dashboard realtime (live data & status)

Monitoring kecepatan dan arah

Mini map LiDAR

Menu navigasi ke halaman About Rover

   
