// import 'package:dojo/screens/presensi_enroll/create_org.dart';
// import 'package:dojo/screens/presensi_enroll/create_presence.dart';
// import 'package:dojo/screens/presensi_enroll/fill_presence.dart';
import 'package:dojo/services/org_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dojo/services/shared_prefs_service.dart';
// import 'presensi_unenroll/org_list.dart';

class LatihanPage extends StatefulWidget {
  final Future<String?> userNameFuture;
  final List<dynamic> orgMembers;
  final List<dynamic> organizations;

  const LatihanPage(
      {super.key,
      required this.userNameFuture,
      required this.orgMembers,
      required this.organizations});

  @override
  _latihanPageState createState() => _latihanPageState();
}

class _latihanPageState extends State<LatihanPage> with WidgetsBindingObserver {
  String? email;
  Map<String, dynamic>? attendanceData;
  String _activeButton = 'Latihan Fisik';
  final Map<String, List<String>> latihanOptions = {
    'Latihan Fisik': ['Push Up', 'Sit Up', 'Back Up', 'Squat', 'Lungees'],
    'Latihan Teknik': ['Tendangan', 'Pukulan', 'Bantingan'],
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchEmailData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Hapus observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Ketika halaman kembali aktif
      if (email != null) {
        _fetchAttendanceData(email!);
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  void _fetchEmailData() async {
    final userData = await getUserData();
    setState(() {
      email = userData['email'];
    });

    if (email != null && email!.isNotEmpty) {
      _fetchAttendanceData(email!);
    }
  }

  void _fetchAttendanceData(String email) async {
    OrganizationService service = OrganizationService();
    final data = await service.fetchAttendanceData(email);
    print('fungsi dipanggil');
    if (data != null) {
      setState(() {
        attendanceData = data;
      });
    }
  }

  String? _getLatestDate() {
    if (attendanceData != null &&
        attendanceData!['attendance_sessions'] != null &&
        email != null) {
      final sessions = attendanceData!['attendance_sessions'] as List;

      if (sessions.isNotEmpty) {
        final records = attendanceData!['attendance_records'] as List? ?? [];
        final userRecords = records.where((record) {
          final userEmail = record['user']['email'];
          return userEmail == email;
        }).toList();

        final latestSession = sessions.last;
        final sessionDate = latestSession['date'];
        final sessionStatus = latestSession['status'];

        if (sessionStatus == 'open') {
          if (userRecords.isEmpty) {
            return sessionDate;
          }

          for (var record in userRecords) {
            final recordDate = record['attendance_session']['date'];
            if (recordDate == sessionDate) {
              return null;
            }
          }

          return sessionDate;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // final hasOrganizations = widget.organizations.isNotEmpty;
    // final hasOrgMembers = widget.orgMembers.isNotEmpty;

    return FutureBuilder<String?>(
      future: widget.userNameFuture,
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

          return Scaffold(
            backgroundColor: const Color(0xFF141F33),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Header Container
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFA3EC3D),
                          width: 8.0,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
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
                        const SizedBox(height: 15),
                        // if (hasOrganizations) ...[
                        Center(
                          child: Column(
                            children: [
                              for (var organization in widget.organizations)
                                Text(
                                  organization['name'],
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontFamily:
                                        GoogleFonts.bebasNeue().fontFamily,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _activeButton = 'Latihan Fisik';
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: BoxDecoration(
                                          color:
                                              _activeButton == 'Latihan Fisik'
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      55, 133, 134, 138),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'LATIHAN FISIK',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: _activeButton ==
                                                      'Latihan Fisik'
                                                  ? const Color(0xFF2E2F3E)
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _activeButton = 'Latihan Teknik';
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: BoxDecoration(
                                          color:
                                              _activeButton == 'Latihan Teknik'
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      55, 133, 134, 138),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'LATIHAN TEKNIK',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: _activeButton ==
                                                      'Latihan Teknik'
                                                  ? const Color(0xFF2E2F3E)
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        // ] else
                        //   const Center(
                        //     child: Text(
                        //       'Tidak ada organisasi yang terdaftar.',
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         color: Colors.white,
                        //         fontStyle: FontStyle.italic,
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: latihanOptions[_activeButton]!.length,
                      itemBuilder: (context, index) {
                        final latihan = latihanOptions[_activeButton]![index];
                        return GestureDetector(
                          onTap: () {
                            print('Latihan dipilih: $latihan');
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 117, 117, 117),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 167, 167, 167),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  latihan,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
