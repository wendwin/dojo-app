import 'package:dojo/services/org_service.dart';
import 'package:dojo/services/presence_service.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FillPresence extends StatefulWidget {
  const FillPresence({super.key});

  @override
  State<FillPresence> createState() => _FillPresenceState();
}

class _FillPresenceState extends State<FillPresence> {
  String? userId;
  String? email;
  Map<String, dynamic>? attendanceData;
  bool isHadir = false;
  bool isIzin = false;

  @override
  void initState() {
    super.initState();
    _fetchIdData();
    _fetchEmailData();
  }

  void _fetchIdData() async {
    final userData = await getUserData();
    setState(() {
      userId = userData['id'].toString();
    });
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
    if (data != null) {
      setState(() {
        attendanceData = data;
      });
    }
  }

  void _handleCheckboxChange(String status, bool? value) {
    setState(() {
      if (status == 'Presensi') {
        isHadir = value ?? false;
        if (isHadir) isIzin = false;
      } else if (status == 'Izin') {
        isIzin = value ?? false;
        if (isIzin) isHadir = false;
      }
    });
  }

  void _submitPresence() async {
    if (userId == null || userId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID pengguna tidak ditemukan')),
      );
      return;
    }

    if (attendanceData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data presensi tidak ditemukan')),
      );
      return;
    }

    var lastOpenSession = attendanceData?['attendance_sessions'].lastWhere(
        (session) => session['status'] == 'open',
        orElse: () => null);

    if (lastOpenSession == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada sesi presensi terbuka')),
      );
      return;
    }

    int attendanceSessionId = lastOpenSession['id'];

    String status = isHadir
        ? 'Presensi'
        : isIzin
            ? 'Izin'
            : 'Belum memilih';

    if (status == 'Belum memilih') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih status kehadiran')),
      );
      return;
    }

    AttendanceService service = AttendanceService();

    final response = await service.submitPresence(
      userId: int.parse(userId ?? ''),
      attendanceSessionId: attendanceSessionId,
      status: status,
    );

    if (response != null && response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Presensi Berhasil'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      final data = response['data'];
      print('Presensi berhasil: $data');

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Presensi Gagal'),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromARGB(255, 229, 58, 43),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF141F33),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/element-t.png',
              fit: BoxFit.cover,
              width: 150,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/element-b.png',
              fit: BoxFit.cover,
              width: 150,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        'Minggu, 20 Oktober 2024',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        '08:00 - 09:00 WIB',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.bebasNeue().fontFamily,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: isHadir,
                                onChanged: (value) {
                                  _handleCheckboxChange('Presensi', value);
                                },
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                        (states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors.blue;
                                  }
                                  return Colors.white;
                                }),
                              ),
                              const Text(
                                'Hadir',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 20),
                              Radio<bool>(
                                value: true,
                                groupValue: isIzin,
                                onChanged: (value) {
                                  _handleCheckboxChange('Izin', value);
                                },
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                        (states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors.blue;
                                  }
                                  return Colors.white;
                                }),
                              ),
                              const Text(
                                'Izin',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: ElevatedButton(
                              onPressed: _submitPresence,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFA3EC3D),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
