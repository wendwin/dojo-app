import 'package:dojo/screen/latihan.dart';
import 'package:dojo/screen/presensi_unenroll.dart';
import 'package:dojo/screen/profile.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:dojo/models/org_model.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:dojo/services/org_service.dart';

class Unenroll extends StatefulWidget {
  const Unenroll({super.key});

  @override
  State<Unenroll> createState() => _UnenrollState();
}

class _UnenrollState extends State<Unenroll> {
  int _currentIndex = 0;
  String? userName;
  List<Organization>? organizations;

  @override
  void initState() {
    super.initState();
    loadUserName();
    loadOrganizations();
  }

  Future<void> loadUserName() async {
    final userData = await getUserData();
    setState(() {
      userName = userData['userName'];
    });
  }

  Future<void> loadOrganizations() async {
    OrganizationService service = OrganizationService();
    final orgs = await service.fetchOrganizations();
    if (orgs != null && orgs.isNotEmpty) {
      print('Jumlah organisasi ditemukan: ${orgs.length}');
    } else {
      print('Tidak ada organisasi ditemukan');
    }
    setState(() {
      organizations = orgs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      UnenrollPresensiPage(
        userName: userName,
      ),
      const LatihanPage(),
      ProfilePage(organizations: organizations),
    ];
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
