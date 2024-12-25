// import 'package:dojo/components/bottom_nav.dart';
// import 'package:dojo/screens/latihan.dart';
// // import 'package:dojo/screens/presensi_enroll/presensi.dart';
// import 'package:dojo/screens/presensi_unenroll/unenroll_presensi.dart';
// import 'package:dojo/screens/profile.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:dojo/models/org_model.dart';
// import 'package:dojo/services/shared_prefs_service.dart';
// // import 'package:dojo/services/org_service.dart';

// class Unenroll extends StatefulWidget {
//   const Unenroll({super.key});

//   @override
//   State<Unenroll> createState() => _UnenrollState();
// }

// class _UnenrollState extends State<Unenroll> {
//   int _currentIndex = 0;
//   final List<GlobalKey<NavigatorState>> _navigatorKeys = [
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];

//   late Future<String?> _userNameFuture;
//   late Future<Map<String, dynamic>> _orgDataFuture;
//   List<dynamic> orgMembers = [];
//   List<dynamic> organizations = [];

//   @override
//   void initState() {
//     super.initState();
//     _userNameFuture = _fetchUserName();
//     _orgDataFuture = _fetchOrgData();
//     // _loadUserDataLogin();
//     // loadOrganizations();
//   }

//   Future<String?> _fetchUserName() async {
//     final userData = await getUserData();
//     return userData['name'];
//   }

//   Future<Map<String, dynamic>> _fetchOrgData() async {
//     final userData = await getUserData(); // Ambil data user
//     return {
//       'org_members': userData['org_members'] ?? [],
//       'organizations': userData['organizations'] ?? [],
//     };
//   }

//   // Future<void> _loadUserDataLogin() async {
//   //   final userData = await getUserData();

//   //   setState(() {
//   //     orgMembers = List<dynamic>.from(userData['org_members'] ?? []);
//   //     organizations = List<dynamic>.from(userData['organizations'] ?? []);
//   //   });
//   // }
//   // Future<void> loadOrganizations() async {
//   //   OrganizationService service = OrganizationService();
//   //   final orgs = await service.fetchOrganizations();
//   //   if (orgs != null && orgs.isNotEmpty) {
//   //     print('Jumlah organisasi ditemukan: ${orgs.length}');
//   //   } else {
//   //     print('Tidak ada organisasi ditemukan');
//   //   }
//   //   setState(() {
//   //     organizations = orgs;
//   //   });
//   // }

//   Future<bool> _onWillPop() async {
//     final isFirstRouteInCurrentTab =
//         !(await _navigatorKeys[_currentIndex].currentState?.maybePop() ??
//             false);

//     if (isFirstRouteInCurrentTab) {
//       if (_currentIndex != 0) {
//         setState(() {
//           _currentIndex = 0;
//         });
//         return false;
//       }
//       return true;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         backgroundColor: const Color(0xFF141F33),
//         body: IndexedStack(
//           index: _currentIndex,
//           children: [
//             _buildNavigator(
//               0,
//               UnenrollPresensi(userNameFuture: _userNameFuture),
//             ),
//             _buildNavigator(1, const LatihanPage()),
//             // _buildNavigator(2, ProfilePage()),
//             _buildNavigator(
//               2,
//               FutureBuilder<Map<String, dynamic>>(
//                 future: _orgDataFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text('Error: ${snapshot.error}'),
//                     );
//                   } else if (snapshot.hasData) {
//                     final orgMembers =
//                         snapshot.data!['org_members'] as List<dynamic>;
//                     final organizations =
//                         snapshot.data!['organizations'] as List<dynamic>;

//                     return ProfilePage(
//                       orgMembers: orgMembers,
//                       organizations: organizations,
//                     );
//                   } else {
//                     return const Center(child: Text('No data found.'));
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//         bottomNavigationBar: BottomNavBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildNavigator(int index, Widget child) {
//     return Offstage(
//       offstage: _currentIndex != index,
//       child: Navigator(
//         key: _navigatorKeys[index],
//         onGenerateRoute: (settings) => MaterialPageRoute(
//           builder: (context) => child,
//         ),
//       ),
//     );
//   }
// }
