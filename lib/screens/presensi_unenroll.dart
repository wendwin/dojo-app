// import 'package:dojo/models/org_model.dart';
import 'package:dojo/screens/org_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnenrollPresensiPage extends StatelessWidget {
  final String? userName;
  const UnenrollPresensiPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          'assets/images/element-base.png',
          fit: BoxFit.cover,
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          children: [
            Row(children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(width: 10),
              Center(
                child: userName != null
                    ? Text('$userName',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white))
                    : const CircularProgressIndicator(),
              ),
              // const Text('Alex Supriadi',
              //     style: TextStyle(color: Colors.white)),
            ]),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text('Presensi',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: GoogleFonts.bebasNeue().fontFamily,
                          letterSpacing: 1.5)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Anda belum mengikuti kelas Dojo',
                        style: TextStyle(color: Colors.yellow[400]),
                      ),
                      const SizedBox(width: 5),
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.yellow[400]),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(children: [
              const Icon(Icons.more_time, color: Colors.white),
              const SizedBox(width: 5),
              Text(
                'Riwayat',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 1.5,
                    fontFamily: GoogleFonts.bebasNeue().fontFamily),
              )
            ]),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Tanggal',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Status',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Belum ada riwayat presensi',
                          style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 150),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrganizationList()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA3EC3D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Gabung Kelas',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
