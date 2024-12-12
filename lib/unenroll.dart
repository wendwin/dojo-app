import 'package:dojo/components/bottom_nav.dart';
import 'package:dojo/screens/latihan.dart';
import 'package:dojo/screens/presensi_unenroll/unenroll_presensi.dart';
import 'package:dojo/screens/profile.dart';
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
    final List<Widget> pages = [
      UnenrollPresensi(
        userName: userName,
      ),
      const LatihanPage(),
      const ProfilePage(),
    ];
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF141F33),
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
