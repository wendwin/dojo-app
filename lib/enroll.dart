import 'package:dojo/models/org_model.dart';
import 'package:dojo/screens/presensi_unenroll/input_enroll.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class InputEnroll extends StatefulWidget {
  const InputEnroll({super.key, required Organization org});

  @override
  State<InputEnroll> createState() => _InputEnrollState();
}

class _InputEnrollState extends State<InputEnroll> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const InputEnrollPage(),
    const LatihanPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(255, 204, 204, 204),
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios_new_outlined),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
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
  const ProfilePage({super.key, List<Organization>? organizations});

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
