import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PresensiPage extends StatelessWidget {
  final Future<String?> userNameFuture;

  const PresensiPage({super.key, required this.userNameFuture});

  @override
  Widget build(BuildContext context) {
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
                  'assets/images/element-base.png',
                  fit: BoxFit.cover,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Presensi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: GoogleFonts.bebasNeue().fontFamily,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Satria Monoreh',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  backgroundColor: const Color(0xFFA3EC3D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
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
                      child: Column(
                        children: [
                          // Header
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tanggal',
                                    style: TextStyle(color: Colors.white)),
                                Text('Status',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          const _RiwayatRow(
                              date: '20 Oktober 2024', status: 'Hadir'),
                          const Divider(color: Colors.grey),
                          const _RiwayatRow(
                              date: '21 Oktober 2024', status: 'Tidak Hadir'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'Lihat lebih banyak',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
