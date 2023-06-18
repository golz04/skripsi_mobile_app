import 'dart:async';
import 'package:flutter/material.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                // borderRadius: BorderRadius.circular(12),
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset(5, 5),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade800,
                    offset: const Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  )
                ]),
            child: Image.asset(
              'assets/images/rice_plant_logo.png',
              height: 130,
            ),
          ),
        ),
      ),
    );
  }
}
