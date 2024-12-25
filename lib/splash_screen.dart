// import 'package:dojo/services/shared_prefs_service.dart';
import 'package:dojo/login.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:dojo/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      // navigateBasedOnLoginStatus(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141F33),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo-dojo.png'),
            const SizedBox(height: 25),
            Text('Dojo',
                style: TextStyle(
                    color: const Color(0xFFA3EC3D),
                    fontSize: 40,
                    fontFamily: GoogleFonts.bebasNeue().fontFamily)),
          ],
        ),
      ),
    );
  }
}

Future<void> navigateBasedOnLoginStatus(BuildContext context) async {
  bool isLoggedIn = await checkLoginStatus();
  if (isLoggedIn) {
    print('Login status: sudah login');
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    print('Login status: belum login');
    Navigator.pushReplacementNamed(context, '/login');
  }
}
