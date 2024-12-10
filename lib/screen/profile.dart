import 'package:dojo/login.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:dojo/models/org_model.dart';

class ProfilePage extends StatelessWidget {
  final List<Organization>? organizations;

  const ProfilePage({super.key, required this.organizations});

  Future<void> _logoutUser(BuildContext context) async {
    await logoutUser();
    print("User data cleared: userId and userName have been removed.");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
      color: const Color(0xFF141F33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          if (organizations == null) ...[
            const Center(child: CircularProgressIndicator()),
          ] else if (organizations!.isEmpty) ...[
            const Text(
              'No organizations found.',
              style: TextStyle(color: Colors.white),
            ),
          ] else ...[
            const Text(
              'Organizations:',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
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
          const SizedBox(height: 20),
          // Logout button
          Center(
            child: ElevatedButton(
              onPressed: () => _logoutUser(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color for logout
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
