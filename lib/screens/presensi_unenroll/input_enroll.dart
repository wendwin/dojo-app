import 'package:dojo/models/org_model.dart';
import 'package:dojo/screens/presensi.dart';
// import 'package:dojo/screens/presensi_enroll/presensi.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:dojo/services/org_service.dart'; // Import service

class InputEnrollPage extends StatefulWidget {
  final Organization? org;
  final List<dynamic>? orgMembers;
  final List<dynamic>? organizations;

  const InputEnrollPage(
      {super.key, this.org, this.orgMembers, this.organizations});

  @override
  State<InputEnrollPage> createState() => _InputEnrollPageState();
}

class _InputEnrollPageState extends State<InputEnrollPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _enrollCodeController = TextEditingController();
  final OrganizationJoinService _organizationJoinService =
      OrganizationJoinService();

  bool _isLoading = false;

  Future<Map<String, dynamic>> _fetchOrgData() async {
    final userData = await getUserData();
    return {
      'org_members': userData['org_members'] ?? [],
      'organizations': userData['organizations'] ?? [],
    };
  }

  @override
  void dispose() {
    _enrollCodeController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final enrollCode = _enrollCodeController.text;

      try {
        final userData = await getUserData();
        final userId = userData['id'] ?? '';
        final userName = userData['name'];

        if (userId == null) {
          throw Exception("User ID tidak valid");
        }

        final isSuccess = await _organizationJoinService.joinOrganization(
          userId,
          enrollCode,
        );

        if (isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Berhasil bergabung ke organisasi'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );

          final userId = (userData['id']?.toString() ?? '');

          final updatedUserData =
              await _organizationJoinService.fetchUserData(userId);

          await saveUserData(updatedUserData, userData['token']);

          // final updatedOrgData = await _fetchOrgData();

          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PresensiPage(
                          userNameFuture: Future.value(userName),
                          orgMembers: updatedUserData['org_members'] ?? [],
                          organizations: updatedUserData['organizations'] ?? [],
                        )));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal bergabung ke organisasi'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
            padding: const EdgeInsets.fromLTRB(30, 80, 30, 30),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Masukan Kode Enroll',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 15),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _enrollCodeController,
                          decoration: InputDecoration(
                            hintText: 'Kode enroll',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 211, 211, 211),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kode enroll tidak boleh kosong';
                            }
                            if (value.length < 5) {
                              return 'Kode enroll harus minimal 5 karakter';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA3EC3D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            'Gabung',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
