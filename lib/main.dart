import 'package:android_app/splash.dart';
import 'package:flutter/material.dart'; // Ganti "your_app_name" dengan nama aplikasi Anda

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skripsi Muhammad Haidar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(), // Tampilkan SplashScreen sebagai halaman pertama
    );
  }
}
