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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.0.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Ajustes',
              style: TextStyle(
                  color: Colors.red.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0.sp),
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          TextButton(
              onPressed: () {
                exitSession();
              },
              child: Text(
                'Cerrar sesión',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  exitSession() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ));
  }
}
