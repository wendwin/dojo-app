import 'package:dojo/login.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:dojo/models/org_model.dart';

class ProfilePage extends StatelessWidget {
  // final List<Organization>? organizations;

  const ProfilePage({super.key});

  Future<void> _logoutUser(BuildContext context) async {
    await logoutUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      color: const Color(0xFF141F33),
      child: Column(children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Color(0xFFA3EC3D),
              ),
              child: Center(
                child: Text(
                  'Maman',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: GoogleFonts.bebasNeue().fontFamily,
                      letterSpacing: 2),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color:
                      Colors.black, // Ganti dengan warna border yang diinginkan
                  width: 2, // Ketebalan border
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
              ),
              child: const Column(
                children: [
                  _RiwayatRow(date: 'Alamat', status: 'Yogyakarta'),
                  Divider(color: Colors.grey, thickness: 2),
                  _RiwayatRow(date: 'No. Hp', status: '089888223444'),
                  Divider(color: Colors.grey, thickness: 2),
                  _RiwayatRow(date: 'Email', status: 'maman@gmail.com'),
                  Divider(color: Colors.grey, thickness: 2),
                  _RiwayatRow(date: 'Jenis Kelamin', status: 'Laki-laki'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
              ),
              child: const Column(
                children: [
                  _RiwayatRow(date: 'Dojo', status: 'Satria Monoreh'),
                  Divider(color: Colors.grey, thickness: 2),
                  _RiwayatRow(date: 'Anggota', status: 'Alex Supriadi'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _logoutUser(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 219, 219, 219),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Color.fromARGB(255, 41, 41, 41)),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Text(
      //       'Profile',
      //       style: TextStyle(fontSize: 24, color: Colors.white),
      //     ),
      //     const SizedBox(height: 20),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => DetailPage()),
      //         );
      //       },
      //       child: Text('Go to Detail Page'),
      //     ),
      //     const SizedBox(height: 20),
      //     // Logout button
      //     Center(
      //       child: ElevatedButton(
      //         onPressed: () => _logoutUser(context),
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.red,
      //           padding:
      //               const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      //         ),
      //         child: const Text(
      //           'Logout',
      //           style: TextStyle(fontSize: 18),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class _RiwayatRow extends StatelessWidget {
  final String date;
  final String status;

  const _RiwayatRow({required this.date, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date, style: const TextStyle(color: Colors.white)),
        Text(status, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: const Center(
        child: Text('This is the detail page'),
      ),
    );
  }
}
