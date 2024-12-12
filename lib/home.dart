import 'package:dojo/components/bottom_nav.dart';
import 'package:dojo/models/org_model.dart';
import 'package:dojo/screens/latihan.dart';
import 'package:dojo/screens/presensi_enroll/presensi.dart';
import 'package:dojo/screens/profile.dart';
import 'package:dojo/services/org_service.dart';
import 'package:flutter/material.dart';
import 'package:dojo/services/shared_prefs_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      PresensiPage(
        userName: userName,
      ),
      const LatihanPage(),
      ProfilePage(organizations: organizations),
    ];

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF141F33),
        body: _pages[_currentIndex],
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
