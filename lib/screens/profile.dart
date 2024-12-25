import 'package:dojo/login.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:dojo/models/org_model.dart';

class ProfilePage extends StatelessWidget {
  // final List<Organization>? organizations;
  final List<dynamic> orgMembers;
  final List<dynamic> organizations;

  const ProfilePage(
      {super.key, required this.orgMembers, required this.organizations});

  Future<Map<String, dynamic>> _getUserData() async {
    return await getUserData();
  }

  Future<void> _logoutUser(BuildContext context) async {
    await logoutUser();
    // Hapus semua rute sebelumnya dan arahkan ke halaman login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false, // Menghapus semua rute sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {
    // bool hasOrgOrMembership = orgMembers.isNotEmpty && organizations.isNotEmpty;
    // final hasOrganizations = organizations.isNotEmpty;
    // final hasOrgMembers = orgMembers.isNotEmpty;

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Tidak ada data pengguna.'));
          }

          final userData = snapshot.data!;
          final String name = userData['name'] ?? 'Tidak ada nama';
          final String email = userData['email'] ?? 'Tidak ada email';
          final List<dynamic> orgMembers = userData['org_members'] ?? [];
          final List<dynamic> organizations = userData['organizations'] ?? [];

          return _buildProfilePage(
            context,
            name: name,
            email: email,
            orgMembers: orgMembers,
            organizations: organizations,
          );
        },
      ),
    );
  }

  Widget _buildProfilePage(
    BuildContext context, {
    required String name,
    required String email,
    required List<dynamic> orgMembers,
    required List<dynamic> organizations,
  }) {
    final hasOrganizations = organizations.isNotEmpty;
    final hasOrgMembers = orgMembers.isNotEmpty;

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
                  name,
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
              child: Column(
                children: [
                  const _RiwayatRow(date: 'Alamat', status: 'Yogyakarta'),
                  const Divider(color: Colors.grey, thickness: 2),
                  const _RiwayatRow(date: 'No. Hp', status: '089888223444'),
                  const Divider(color: Colors.grey, thickness: 2),
                  _RiwayatRow(date: 'Email', status: email),
                  const Divider(color: Colors.grey, thickness: 2),
                  const _RiwayatRow(date: 'Jenis Kelamin', status: 'Laki-laki'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (!hasOrganizations && !hasOrgMembers)
              // Jika orgMembers dan organizations kosong, tampilkan tombol
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Arahkan ke halaman buat organisasi
                      print("Navigate to Create Organization");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA3EC3D),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                    ),
                    child: const Text(
                      'Buat Organisasi',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Arahkan ke halaman join organisasi
                      print("Navigate to Join Organization");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA3EC3D),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                    ),
                    child: const Text(
                      'Gabung Organisasi',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            else
              // Jika orgMembers atau organizations tidak kosong, tampilkan kontainer
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailPage()),
                        );
                      },
                      child: const _RiwayatRow(
                          date: 'Dojo', status: 'Satria Monoreh'),
                    ),
                    const Divider(color: Colors.grey, thickness: 2),
                    const _RiwayatRow(date: 'Anggota', status: 'Alex Supriadi'),
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
            ),
            const SizedBox(height: 5),
            Container(
                child: Column(
              children: [
                Text(
                  'Organizations: ${organizations.length}',
                  style: TextStyle(color: Colors.white),
                ), // Menampilkan jumlah organisasi
                // Tampilkan orgMembers jika diperlukan
                Text(
                  'Org Members: ${orgMembers.length}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ))
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
      backgroundColor: const Color(0xFF141F33),
      appBar: AppBar(title: const Text('Detail Page')),
      body: const Center(
        child: Text('This is the detail page'),
      ),
    );
  }
}
