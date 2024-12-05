import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PresensiPage(),
    const LatihanPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF141F33),
        body: _pages[_currentIndex],
        bottomNavigationBar: ClipRRect(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF808080),
            selectedItemColor: const Color(0xFFA3EC3D),
            unselectedItemColor: const Color(0xFF141F33),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.date_range),
                label: 'Presensi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.auto_stories_outlined),
                label: 'Latihan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PresensiPage extends StatelessWidget {
  const PresensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          'assets/images/element-base.png',
          fit: BoxFit.cover, // Mengisi seluruh layar dengan gambar
          // height: MediaQuery.of(context).size.height *
          //     0.5, // Menyesuaikan ukuran gambar (hanya setengah layar)
        ),
      ),
      Container(
        padding: const EdgeInsets.all(30),
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
              const SizedBox(width: 15),
              const Text('Alex Supriadi',
                  style: TextStyle(color: Colors.white)),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '20 Oktober 2024',
                        style: TextStyle(
                            color: Color(0xFFA3EC3D),
                            fontWeight: FontWeight.w500),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 40),
                          backgroundColor: const Color(0xFFA3EC3D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Baru',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      )
                      // Container(
                      //   width: 70,
                      //   height: 30,
                      //   decoration: BoxDecoration(
                      //     color: Color(0xFFA3EC3D),
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       'Baru',
                      //       style: TextStyle(
                      //           color: Colors.white, fontWeight: FontWeight.w500),
                      //     ),
                      //   ),
                      // )
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
              height: 200,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('20 Oktober 2024',
                          style: TextStyle(color: Colors.white)),
                      Text('Hadir', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(children: [
                    Container(
                        width: double.infinity,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ))
                  ]),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('20 Oktober 2024',
                          style: TextStyle(color: Colors.white)),
                      Text('Hadir', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(children: [
                    Container(
                        width: double.infinity,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ))
                  ])
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Lihat',
                style: TextStyle(color: Colors.white),
              )
            ])
          ],
        ),
      ),
    ]);
  }
}

class LatihanPage extends StatelessWidget {
  const LatihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Latihan',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
