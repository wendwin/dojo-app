import 'package:flutter/material.dart';

class InputEnrollPage extends StatelessWidget {
  const InputEnrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          'assets/images/element-base.png',
          fit: BoxFit.cover, // Mengisi seluruh layar dengan gambar
          // height: MediaQuery.of(context).size.height *
          //     0.5, // Menyesuaikan ukuran gambar (hanya setengah layar)
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(30, 80, 30, 30),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 130,
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
                      child: TextFormField(
                          decoration: InputDecoration(
                    // labelText: 'Masukan Kode Enroll',
                    hintText: 'Kode enroll',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 211, 211, 211),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ))),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA3EC3D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Gabung',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
