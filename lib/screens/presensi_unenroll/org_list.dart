// import 'package:dojo/enroll.dart';
import 'package:dojo/models/org_model.dart';
import 'package:dojo/screens/presensi_unenroll/input_enroll.dart';
// import 'package:dojo/screen/presensi_unenroll.dart';
// import 'package:dojo/screen/profile.dart';
import 'package:dojo/services/org_service.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';

// import 'latihan.dart';

class OrganizationList extends StatefulWidget {
  const OrganizationList({super.key});

  @override
  State<OrganizationList> createState() => _OrganizationListState();
}

class _OrganizationListState extends State<OrganizationList> {
  // int _currentIndex = 0;
  String? userName;
  List<Organization>? organizations;
  // Future<Map<String, dynamic>>? _orgDataFuture;

  @override
  void initState() {
    super.initState();
    loadUserName();
    loadOrganizations();
    // _orgDataFuture = _fetchOrgData();
  }

  Future<void> loadUserName() async {
    final userData = await getUserData();
    setState(() {
      userName = userData['name'];
    });
  }

  // Future<Map<String, dynamic>> _fetchOrgData() async {
  //   final userData = await getUserData(); // Ambil data user
  //   return {
  //     'org_members': userData['org_members'] ?? [],
  //     'organizations': userData['organizations'] ?? [],
  //   };
  // }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('Kontingen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF141F33),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        color: const Color(0xFF141F33),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (organizations == null) ...[
              // Text('Gagal Fetch')
              const Center(child: CircularProgressIndicator()),
            ] else if (organizations!.isEmpty) ...[
              const Text(
                'No organizations found.',
                style: TextStyle(color: Colors.white),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: organizations!.length,
                  itemBuilder: (context, index) {
                    final org = organizations![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InputEnrollPage(
                              org: org,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.grey.withOpacity(0.3),
                        child: ListTile(
                          title: Text(
                            org.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Pelatih: ${org.createdBy.name}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
