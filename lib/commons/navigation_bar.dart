import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/screens/home_screen.dart';
import 'package:gdsc_solution_project/screens/search_screen.dart';
import 'package:get/get.dart';

class AppNavigationBar extends StatelessWidget {
  AppNavigationBar({required this.currentIndex, Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  int currentIndex;

  final List<Widget> _screens = [
    AppHomeScreen(),
    const SearchScreen(),
    // Add more screens as needed
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // Handle item tap
        if (index != currentIndex) {
          Get.to(_screens[index]);
          currentIndex = index;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        // Add more BottomNavigationBarItems as needed
      ],
    );
  }
}
