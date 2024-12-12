// import 'package:dojo/home.dart';
import 'package:dojo/home.dart';
import 'package:dojo/register.dart';
import 'package:dojo/unenroll.dart';
import 'package:flutter/material.dart';
import 'package:dojo/services/login_service.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService authService = LoginService();

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
              'assets/images/element.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Masuk',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(height: 30),

                    // Form Input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
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
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFCCCCCC),
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

                                    final user = await authService.login(
                                        email, password, context);

                                    if (user != null) {
                                      print(
                                          'Login successful! Welcome ${user.name}');
                                      print(
                                          'Organizations: ${user.organizations}');
                                      print('OrgMembers: ${user.orgMembers}');

                                      final hasOrganizations =
                                          user.organizations!.isNotEmpty;
                                      final hasOrgMembers =
                                          user.orgMembers!.isNotEmpty;

                                      if (hasOrganizations && hasOrgMembers) {
                                        print('satu');
                                        print(hasOrganizations);
                                        print(hasOrgMembers);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home()));
                                      } else if (hasOrgMembers &&
                                          !hasOrganizations) {
                                        print('dua');
                                        print(hasOrganizations);
                                        print(hasOrgMembers);
                                        // Jika user hanya menjadi anggota organisasi, arahkan ke Unenroll
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home()));
                                      } else {
                                        print('tiga');
                                        print(hasOrganizations);
                                        print(hasOrgMembers);
                                        // Jika user tidak memiliki organisasi dan tidak menjadi anggota, arahkan ke Unenroll
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Unenroll()));
                                      }
                                    } else {
                                      print('Login failed');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Row(
                                            children: [
                                              Icon(Icons.warning_amber_rounded,
                                                  color: Colors.white),
                                              SizedBox(width: 8),
                                              Text(
                                                'Gagal Masuk',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              255, 229, 58, 43),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.all(16),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          // builder: (context) => Register()));
                                          builder: (context) => Register()));
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
