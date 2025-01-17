import 'package:dojo/components/bottom_nav.dart';
import 'package:dojo/screens/latihan.dart';
// import 'package:dojo/screens/presensi_enroll/create_presence.dart';
import 'package:dojo/screens/presensi.dart';
import 'package:dojo/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:dojo/services/shared_prefs_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  late Future<String?> _userNameFuture;
  // String? _roleData;
  late Future<Map<String, dynamic>> _orgDataFuture;
  List<dynamic> orgMembers = [];
  List<dynamic> organizations = [];

  @override
  void initState() {
    super.initState();
    _userNameFuture = _fetchUserName();
    _orgDataFuture = _fetchOrgData();
    // _fetchRoleData();
  }

  Future<String?> _fetchUserName() async {
    final userData = await getUserData();
    return userData['name'];
  }

  // void _fetchRoleData() async {
  //   final userData = await getUserData();
  //   setState(() {
  //     _roleData = userData['role'];
  //   });
  // }

  Future<Map<String, dynamic>> _fetchOrgData() async {
    final userData = await getUserData();
    return {
      'org_members': userData['org_members'] ?? [],
      'organizations': userData['organizations'] ?? [],
    };
  }

  // Future<void> _loadUserDataLogin() async {
  //   final userData = await getUserData();

  //   setState(() {
  //     orgMembers = List<dynamic>.from(userData['org_members'] ?? []);
  //     organizations = List<dynamic>.from(userData['organizations'] ?? []);
  //   });
  // }

  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab =
        !(await _navigatorKeys[_currentIndex].currentState?.maybePop() ??
            false);

    if (isFirstRouteInCurrentTab) {
      if (_currentIndex != 0) {
        setState(() {
          _currentIndex = 0;
        });
        return false;
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _orgDataFuture,
        builder: (context, snapshot) {
          // bool hasData = false;

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            // final orgMembers = snapshot.data!['org_members'] as List<dynamic>;
            // final organizations =
            snapshot.data!['organizations'] as List<dynamic>;
            // hasData = orgMembers.isNotEmpty && organizations.isNotEmpty;
          }

          return Scaffold(
            backgroundColor: const Color(0xFF141F33),
            body: IndexedStack(
              index: _currentIndex,
              children: [
                _buildNavigator(
                  0,
                  FutureBuilder<Map<String, dynamic>>(
                    future: _orgDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        final orgMembers =
                            snapshot.data!['org_members'] as List<dynamic>;
                        final organizations =
                            snapshot.data!['organizations'] as List<dynamic>;

                        return PresensiPage(
                          userNameFuture: _userNameFuture,
                          orgMembers: orgMembers,
                          organizations: organizations,
                        );
                      } else {
                        return const Center(child: Text('No data found.'));
                      }
                    },
                  ),
                ),
                _buildNavigator(
                  1,
                  FutureBuilder<Map<String, dynamic>>(
                    future: _orgDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        final orgMembers =
                            snapshot.data!['org_members'] as List<dynamic>;
                        final organizations =
                            snapshot.data!['organizations'] as List<dynamic>;

                        return LatihanPage(
                          userNameFuture: _userNameFuture,
                          orgMembers: orgMembers,
                          organizations: organizations,
                        );
                      } else {
                        return const Center(child: Text('No data found.'));
                      }
                    },
                  ),
                ),
                _buildNavigator(
                  2,
                  FutureBuilder<Map<String, dynamic>>(
                    future: _orgDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        final orgMembers =
                            snapshot.data!['org_members'] as List<dynamic>;
                        final organizations =
                            snapshot.data!['organizations'] as List<dynamic>;

                        return ProfilePage(
                          orgMembers: orgMembers,
                          organizations: organizations,
                        );
                      } else {
                        return const Center(child: Text('No data found.'));
                      }
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            // floatingActionButton:
            //     ((_currentIndex == 0 && hasData) && _roleData == 'pelatih')
            //         ? FloatingActionButton(
            //             onPressed: () {
            //               // Aksi ketika FAB ditekan
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => (const CreatePresence()),
            //                 ),
            //               );
            //             },
            //             backgroundColor: Color(0xFFA3EC3D), // Warna FAB
            //             child: const Icon(Icons.add), // Ikon FAB
            //           )
            // : null,
          );
        },
      ),
    );
  }

  Widget _buildNavigator(int index, Widget child) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => child,
        ),
      ),
    );
  }
}
