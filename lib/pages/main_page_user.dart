import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:tickets/pages/home_page.dart';
import 'package:tickets/pages/settings.dart';

class MainPageUser extends StatefulWidget {
  const MainPageUser({super.key});

  @override
  State<MainPageUser> createState() => _MainPageUserState();
}

class _MainPageUserState extends State<MainPageUser> {
  PageController controller = PageController(initialPage: 0);
  int selectedIndexBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FluidNavBar(
          onChange: (selectedIndex) {
            controller.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear);
          },
          style: FluidNavBarStyle(
              barBackgroundColor: Colors.red.shade900,
              iconSelectedForegroundColor: Colors.white,
              iconUnselectedForegroundColor: Colors.white,
              iconBackgroundColor: Colors.red.shade900),
          icons: [
            FluidNavBarIcon(icon: Icons.home_outlined),
            FluidNavBarIcon(icon: Icons.person_2_outlined),
          ]),
      body: PageView(
        physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        controller: controller,
        children: const [HomePage(), Settings()],
      ),
    );
  }
}
