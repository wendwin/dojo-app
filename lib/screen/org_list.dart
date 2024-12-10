import 'package:dojo/models/org_model.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFF141F33),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 204, 204, 204),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        color: const Color(0xFF141F33),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Kontingen: ',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            if (organizations == null) ...[
              // Text('Gagal Fetch')
              const Center(child: CircularProgressIndicator()),
            ] else if (organizations!.isEmpty) ...[
              const Text(
                'No organizations found.',
                style: TextStyle(color: Colors.white),
              ),
            ] else ...[
              // const Text(
              //   'Organizations:',
              //   style: TextStyle(fontSize: 18, color: Colors.white),
              // ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: organizations!.length,
                  itemBuilder: (context, index) {
                    final org = organizations![index];
                    return Card(
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
