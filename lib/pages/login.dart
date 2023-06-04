// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets/pages/home_page.dart';
import 'package:tickets/pages/main_page_user.dart';
import 'package:tickets/utils/motion.dart';
import 'dart:math' as math;
import '../utils/clip.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 20.0.h,
            top: -70.0.h,
            left: -100.0.w,
            right: 100.0.w,
            child: Transform.rotate(
              angle: math.pi / 2,
              child: ClipPath(
                clipper: ClipperImage(),
                child: FadeIn(
                  child: Container(
                      width: 100.0.w,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          gradient: LinearGradient(colors: [
                            Colors.red,
                            Colors.red.shade400,
                            Colors.red.shade600
                          ]))),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60.0.h,
            bottom: -10.0.h,
            right: -60.0.w,
            left: 55.0.w,
            child: Transform.rotate(
              angle: math.pi / 1,
              child: ClipPath(
                clipper: ClipperImage(),
                child: Stack(
                  children: [
                    FadeIn(
                      child: Container(
                        width: 100.0.w,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.red,
                          Colors.red.shade400,
                          Colors.red.shade600
                        ])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              physics:
                  const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0.h,
                  ),
                  Image.asset(
                    'assets/logo-apaisado-alta.jpg',
                    width: 80.0.w,
                  ),
                  SizedBox(
                    height: 4.0.h,
                  ),
                  field(
                      mail,
                      'Ingresa tu correo',
                      Icon(
                        Icons.mail,
                        color: Colors.red,
                        size: 7.0.w,
                      ),
                      false),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  field(
                      pass,
                      'Ingresa tu contraseña',
                      Icon(
                        Icons.key,
                        color: Colors.red,
                        size: 7.0.w,
                      ),
                      true),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          minimumSize:
                              MaterialStateProperty.all(Size(80.0.w, 7.0.h))),
                      onPressed: () {
                        auth();
                      },
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                            fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    height: 15.0.h,
                  ),
                  Text(
                    'Molina, ${DateTime.now().year}',
                    style: TextStyle(
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget field(
      TextEditingController controller, String hint, Icon icon, bool isPass) {
    return Container(
      width: 90.0.w,
      height: 7.0.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: TextField(
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0.sp,
              color: Colors.red.shade800),
          obscureText: isPass,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              prefixIcon: icon,
              hintStyle:
                  TextStyle(color: Colors.red.shade200, fontSize: 15.0.sp)),
        ),
      ),
    );
  }

  void auth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                content: Container(
                  color: Colors.white,
                  height: 20.0.h,
                  child: Center(
                      child: Column(
                    children: [
                      Image.asset(
                        'assets/loading.gif',
                        width: 30.0.w,
                      ),
                      Text(
                        'Cargando...',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ),
              ));
      var res = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail.text.trim(), password: pass.text.trim());
      prefs.setString('email', mail.text.trim());
      prefs.setString('uid', res.user!.uid);
      prefs.setBool('isLogged', true);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPageUser(),
          ));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.message!.contains(
          'There is no user record corresponding to this identifier.')) {
        Utils().alertNormal('Usuario no encontrado, verifica tu correo.',
            'No encontrado', context);
      } else if (e.message!.contains(
          'The password is invalid or the user does not have a password.')) {
        Utils().alertNormal(
            'La contraseña es incorrecta. Verifícala.', 'Error', context);
      } else {
        Utils().alertNormal(
            'Ha ocurrido un error. Inténtalo nuevamente.', 'Error', context);
      }
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
