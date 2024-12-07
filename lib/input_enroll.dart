import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class InpurEnroll extends StatefulWidget {
  const InpurEnroll({super.key});

  @override
  State<InpurEnroll> createState() => _InputEnrollState();
}

class _InputEnrollState extends State<InpurEnroll> {
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
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 204, 204, 204),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
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
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Text(
                    'Masukan Kode Enroll',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  Form(
                      child: TextFormField(
                          decoration: InputDecoration(
                    // labelText: 'Masukan Kode Enroll',
                    hintText: 'Kode enroll',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 211, 211, 211),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ))),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA3EC3D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Gabung',
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
