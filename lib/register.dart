import 'package:flutter/material.dart';
// import 'package:presensi/home.dart';
import 'package:dojo/services/register_service.dart';
import 'package:dojo/login.dart';

class Register extends StatelessWidget {
  Register({super.key});
  // String? _roleValue;

  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final List<String> _roles = ['Pelatih', 'Atlet'];
  final RegisterService registerService = RegisterService();

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: FormRegister(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141F33),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/element.png', // Ganti dengan path gambar Anda
              fit: BoxFit.cover, // Mengisi seluruh layar dengan gambar
              // height: MediaQuery.of(context).size.height *
              //     0.5, // Menyesuaikan ukuran gambar (hanya setengah layar)
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Teks "Masuk" di tengah
                  children: [
                    // Teks "Masuk" di tengah
                    const Text(
                      'Daftar',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 30), // Jarak setelah teks "Masuk"

                    // Form Input
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Label di kiri atas
                      children: [
                        // Label Email
                        const Text(
                          'Nama',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        // Input Email
                        TextFormField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFCCCCCC), // Warna abu-abu
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        // Input Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFCCCCCC), // Warna abu-abu
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Label Password
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        // Input Password
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFCCCCCC), // Warna abu-abu
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 20),
                        // const Text(
                        //   'Confirm Password',
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        // const SizedBox(height: 10),
                        // // Input Password
                        // TextField(
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: const Color(0xFFCCCCCC), // Warna abu-abu
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //       borderSide: BorderSide.none,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final success =
                                        await registerService.registerUser(
                                      _namaController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                    );

                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Row(
                                            children: [
                                              Icon(Icons.check_circle,
                                                  color: Colors
                                                      .white), // Ikon di samping teks
                                              SizedBox(width: 8),
                                              Text(
                                                'Pendaftaran Berhasil',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.all(16),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );

                                      await Future.delayed(
                                          const Duration(seconds: 3));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Row(
                                            children: [
                                              Icon(Icons.error,
                                                  color: Colors
                                                      .white), // Ikon di samping teks
                                              SizedBox(width: 8),
                                              Text(
                                                'Pendaftaran Gagal',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.all(16),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );

                                      _namaController.clear();
                                      _emailController.clear();
                                      _passwordController.clear();
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFA3EC3D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Daftar',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 15, 15, 15),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Sudah Punya Akun?',
                                  style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          // builder: (context) => Register()));
                                          builder: (context) => Login()));
                                },
                                child: const Text(' Login',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 55, 156, 218))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text('Belum Punya Akun?',
                          //         style: TextStyle(color: Colors.white)),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) => Register()));
                          //       },
                          //       child: Text(' Daftar',
                          //           style: TextStyle(
                          //               color: const Color.fromARGB(
                          //                   255, 55, 156, 218))),
                          //     ),
                          //     SizedBox(
                          //       height: 20,
                          //     ),
                          //   ],
                          // )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
