import 'package:flutter/material.dart';
import 'package:dojo/services/login_service.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Loginservice authService = Loginservice();

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
                      'Masuk',
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
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        // Input Email
                        TextFormField(
                          controller: emailController,
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
                          controller: passwordController,
                          obscureText: true,
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
                        const SizedBox(height: 20),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Lupa Kata Sandi?',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 20,
                        ),
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
                                    final email = emailController.text.trim();
                                    final password = passwordController.text;

                                    // Panggil service login
                                    final user = await authService.login(
                                        email, password);

                                    if (user != null) {
                                      // Login berhasil
                                      print(
                                          'Login successful! Welcome ${user.nama}');
                                      // Navigasi ke halaman lain atau simpan data user ke state
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => Home()));
                                    } else {
                                      // Login gagal
                                      print('Login failed');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Invalid email or password')),
                                      );

                                      passwordController.clear();
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFA3EC3D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Masuk',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 15, 15, 15),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Belum Punya Akun?',
                                  style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         // builder: (context) => Register()));
                                  //         builder: (context) => Register()));
                                },
                                child: const Text(' Daftar',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 55, 156, 218))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
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

// class FormLogin extends StatefulWidget {
//   const FormLogin({super.key});

//   @override
//   State<FormLogin> createState() => _FormLoginState();
// }

// class _FormLoginState extends State<FormLogin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF141F33),
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/images/element.png', // Ganti dengan path gambar Anda
//               fit: BoxFit.cover, // Mengisi seluruh layar dengan gambar
//               // height: MediaQuery.of(context).size.height *
//               //     0.5, // Menyesuaikan ukuran gambar (hanya setengah layar)
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment:
//                     CrossAxisAlignment.center, // Teks "Masuk" di tengah
//                 children: [
//                   // Teks "Masuk" di tengah
//                   const Text(
//                     'Masuk',
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                   const SizedBox(height: 30), // Jarak setelah teks "Masuk"

//                   // Form Input
//                   Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start, // Label di kiri atas
//                     children: [
//                       // Label Email
//                       const Text(
//                         'Email',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       const SizedBox(height: 10),
//                       // Input Email
//                       TextField(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFFCCCCCC), // Warna abu-abu
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       // Label Password
//                       const Text(
//                         'Password',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       const SizedBox(height: 10),
//                       // Input Password
//                       TextField(
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFFCCCCCC), // Warna abu-abu
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('Lupa Kata Sandi?',
//                           style: TextStyle(color: Colors.white)),
//                       SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: double.infinity,
//                           height: 50,
//                           child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Home()));
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFFA3EC3D),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8)),
//                               ),
//                               child: Text('Masuk',
//                                   style: TextStyle(
//                                       color:
//                                           const Color.fromARGB(255, 15, 15, 15),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold))),
//                         ),
//                         const SizedBox(height: 25),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Belum Punya Akun?',
//                                 style: TextStyle(color: Colors.white)),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         // builder: (context) => Register()));
//                                         builder: (context) => Register()));
//                               },
//                               child: Text(' Daftar',
//                                   style: TextStyle(
//                                       color: const Color.fromARGB(
//                                           255, 55, 156, 218))),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                           ],
//                         )
//                       ])
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _FormLoginState extends State<FormLogin> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF141F33),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Text('Masuk',
//                   style: TextStyle(color: Colors.white, fontSize: 24)),
//               SizedBox(
//                 height: 100,
//               ),
//             ]),

//             // form
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Email', style: TextStyle(color: Colors.white)),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFCCCCCC), // Warna abu-abu
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text('Password', style: TextStyle(color: Colors.white)),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: const Color(0xFFCCCCCC), // Warna abu-abu
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             )

//             // Tambahkan widget lain seperti TextField atau Button di sini
//           ],
//         ),
//       ),
//     );
//   }
// }
