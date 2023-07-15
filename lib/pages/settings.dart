// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets/pages/login.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String email = "";
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Mi perfil',
          //     style: TextStyle(
          //         color: Colors.red.shade800,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20.0.sp),
          //   ),
          // ),
          SizedBox(
            height: 3.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 20.0.w,
                    backgroundColor: Colors.red.shade800,
                    child: CircleAvatar(
                      radius: 19.0.w,
                      backgroundColor: Colors.red,
                      backgroundImage:
                          const AssetImage('assets/vertical-oficio.jpg'),
                      child: CircleAvatar(
                        radius: 19.0.w,
                        backgroundColor: Colors.black38,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30.0.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10.0.h,
          ),
          Column(
            children: [
              ListTile(
                onTap: () {
                  exitSession();
                },
                leading: Icon(
                  Icons.exit_to_app,
                  size: 7.0.w,
                  color: Colors.red.shade800,
                ),
                title: Text(
                  'Cerrar mi sesión',
                  style: TextStyle(color: Colors.black, fontSize: 16.0.sp),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red.shade800,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  exitSession() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Cerrar sesión?'),
          content: const Text('¿Estás seguro que deseas cerrar tu sesión?'),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.black))),
            TextButton(
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
              },
              child: Text('Cerrar sesión',
                  style: TextStyle(color: Colors.red.shade800)),
            ),
          ],
        );
      },
    );
  }
}
