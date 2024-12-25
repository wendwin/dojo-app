import 'package:dojo/screens/presensi_enroll/create_org.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../presensi_unenroll/org_list.dart';

class PresensiPage extends StatelessWidget {
  final Future<String?> userNameFuture;
  final List<dynamic> orgMembers;
  final List<dynamic> organizations;

  const PresensiPage(
      {super.key,
      required this.userNameFuture,
      required this.orgMembers,
      required this.organizations});

  @override
  Widget build(BuildContext context) {
    final hasOrganizations = organizations.isNotEmpty;
    final hasOrgMembers = orgMembers.isNotEmpty;

    return FutureBuilder<String?>(
      future: userNameFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          final userName = snapshot.data ?? 'Unknown User';

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/element-t.png',
                  fit: BoxFit.cover,
                  width: 150,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/element-b.png',
                  fit: BoxFit.cover,
                  width: 150,
                ),
              ),
              // Main Content
              Container(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: (hasOrganizations && hasOrgMembers) ||
                              (!hasOrganizations && hasOrgMembers)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Presensi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily:
                                        GoogleFonts.bebasNeue().fontFamily,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      hasOrganizations
                                          ? organizations[0]['name'] ?? '-'
                                          : 'Tidak Ada Organisasi',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      '|',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      hasOrgMembers
                                          ? orgMembers[0]['user']['role'] ?? '-'
                                          : 'Tidak Ada Role',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '20 Oktober 2024',
                                      style: TextStyle(
                                        color: Color(0xFFA3EC3D),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(60, 35),
                                        backgroundColor:
                                            const Color(0xFFA3EC3D),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Baru',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text('Presensi',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily:
                                            GoogleFonts.bebasNeue().fontFamily,
                                        letterSpacing: 1.5)),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Anda belum mengikuti kelas Dojo',
                                      style:
                                          TextStyle(color: Colors.yellow[400]),
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
                    Row(
                      children: [
                        const Icon(Icons.more_time, color: Colors.white),
                        const SizedBox(width: 5),
                        Text(
                          'Riwayat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1.5,
                            fontFamily: GoogleFonts.bebasNeue().fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: (hasOrganizations && hasOrgMembers) ||
                              (!hasOrganizations && hasOrgMembers)
                          ? Column(
                              children: [
                                // Header
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  width: double.infinity,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Tanggal',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text('Status',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const _RiwayatRow(
                                    date: '20 Oktober 2024', status: 'Hadir'),
                                const Divider(color: Colors.grey),
                                const _RiwayatRow(
                                    date: '21 Oktober 2024',
                                    status: 'Tidak Hadir'),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                ),
                              ],
                            ),
                    ),
                    Column(
                      children: (hasOrganizations && hasOrgMembers) ||
                              (!hasOrganizations && hasOrgMembers)
                          ? [
                              const SizedBox(height: 30),
                              const Center(
                                child: Text(
                                  'Lihat lebih banyak',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]
                          : [
                              const SizedBox(height: 20),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrganizationList()),
                                        );
                                        // Aksi ketika "Gabung organisasi" diklik
                                        print("Gabung organisasi diklik!");
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => GabungOrganisasiPage()));
                                      },
                                      child: const Text(
                                        'Gabung organisasi',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'atau',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreateOrganization()),
                                        );
                                        // Aksi ketika "Buat organisasi" diklik
                                        print("Buat organisasi diklik!");
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => BuatOrganisasiPage()));
                                      },
                                      child: const Text(
                                        'Buat organisasi',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                    )
                  ],
                ),
              ),
            ],
          );
        }
      },
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
