// import 'package:dojo/screens/presensi_enroll/presensi.dart';
import 'package:dojo/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:dojo/services/presence_service.dart';

class CreatePresence extends StatefulWidget {
  const CreatePresence({super.key});

  @override
  State<CreatePresence> createState() => _CreatePresenceState();
}

class _CreatePresenceState extends State<CreatePresence> {
  final _formKey = GlobalKey<FormState>();
  String? _userId;
  String? _orgId;
  String? _selectedDate;
  String? _openingTime;
  String? _closingTime;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await getUserData();

    setState(() {
      _userId = userData['id'].toString();
      if (userData['org_members'].isNotEmpty) {
        _orgId = userData['organizations'][0]['id'].toString();
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> _selectOpeningTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _openingTime =
            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
      });
    }
  }

  Future<void> _selectClosingTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _closingTime =
            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _openingTime != null &&
        _closingTime != null) {
      final presenceService = PresenceService();

      try {
        final result = await presenceService.createPresence(
          userId: int.parse(_userId!),
          orgId: int.parse(_orgId!),
          date: _selectedDate!,
          timeOpen: '$_openingTime',
          timeClose: '$_closingTime',
          context: context,
        );

        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Berhasil menambahkan presensi'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );

          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141F33),
      appBar: AppBar(title: const Text('Tambah Presensi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextButton(
                onPressed: _selectDate,
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      _selectedDate == null
                          ? 'Tanggal'
                          : 'Date: $_selectedDate',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _selectOpeningTime,
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      _openingTime == null
                          ? 'Waktu Buka'
                          : 'Time: $_openingTime',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _selectClosingTime,
                child: Row(
                  children: [
                    const Icon(Icons.timelapse_sharp, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      _closingTime == null
                          ? 'Waktu Tutup'
                          : 'Time: $_closingTime',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Buat Presensi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
