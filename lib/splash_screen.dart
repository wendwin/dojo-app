// import 'package:dojo/services/shared_prefs_service.dart';
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
      Navigator.pushReplacementNamed(context, '/login');
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

// Fungsi untuk memeriksa status login
// Future<void> checkLoginStatus(BuildContext context) async {
//   final userData =
//       await getUserData(); // Mendapatkan data pengguna dari SharedPreferences

//   // Cek apakah userId ada (menandakan sudah login)
//   if (userData['userId'] != null) {
//     final org =
//         await getUserOrganization(); // Mendapatkan informasi organisasi pengguna
//     final orgMembers =
//         userData['orgMembers']; // Mendapatkan informasi orgMembers pengguna

//     // Pastikan orgMembers dan org tidak null
//     final hasOrg = org != null && org.isNotEmpty;
//     final hasOrgMembers = orgMembers != null && orgMembers.isNotEmpty;

//     // Cek kondisi untuk navigasi
//     if (hasOrg || hasOrgMembers) {
//       // Jika ada org atau orgMembers (dianggap sudah memiliki organisasi)
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       // Jika org dan orgMembers kosong, arahkan ke halaman select-org
//       Navigator.pushReplacementNamed(context, '/select-org');
//     }
//   } else {
//     // Jika belum login, arahkan ke halaman login
//     Navigator.pushReplacementNamed(context, '/login');
//   }
// }
