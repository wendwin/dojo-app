import 'package:dojo/home.dart';
import 'package:dojo/login.dart';
import 'package:dojo/splash_screen.dart';
// import 'package:dojo/unenroll.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const SplashScreen(),
    routes: {
      '/home': (context) => const Home(),
      '/login': (context) => Login(),
      // '/select-org': (context) => const Unenroll(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
