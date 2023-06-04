import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:tickets/pages/home_page.dart';
import 'package:tickets/pages/login.dart';
import 'package:tickets/pages/main_page_user.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLogged = false;
  @override
  void initState() {
    super.initState();
    afterTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.0.h,
            ),
            FadeInDown(
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/logo molina blanco_horizontal.png',
                width: 80.0.w,
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            const CircularProgressIndicator(
              color: Colors.red,
              backgroundColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  afterTime() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogged = prefs.getBool('isLogged') ?? false;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (isLogged == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPageUser(),
            ));
      }
    });
  }
}
