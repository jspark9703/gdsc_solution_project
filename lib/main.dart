import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/firebase_options.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:gdsc_solution_project/screens/detail_list_screen.dart';
import 'package:gdsc_solution_project/screens/filter_screen.dart';
import 'package:gdsc_solution_project/screens/home_screen.dart';
import 'package:gdsc_solution_project/screens/detail_screen.dart';
import 'package:gdsc_solution_project/screens/land_screen.dart';
import 'package:gdsc_solution_project/screens/login_screen.dart';
import 'package:gdsc_solution_project/screens/register_info_screen.dart';
import 'package:gdsc_solution_project/screens/register_screen.dart';
import 'package:gdsc_solution_project/screens/search_screen.dart';
import 'package:gdsc_solution_project/screens/selected_list_screen.dart';
import 'package:gdsc_solution_project/screens/user_manager_screen.dart';
import 'package:get/get.dart';

import 'widgets/filter_screen/selcet_price_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Pretendard'),
      routes: {
        "/": (context) => LandScreen(),
        '/login': (context) => LoginScreen(),
        '/reg': (context) => RegisterScreen(),
        '/reg/reg_info':(context) => RegisterInfoScreen(),
        '/search': (context) => const SearchScreen(),
        
        '/search/select_filter_screen': (context) => const FilterScreen(),
        '/selected_list':(context) => SelectedListScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => UserManagerScreen(),
        '/detaillist': (context) => DetailListScreen(),
        '/detail:isbssturl': (context) => DetailScreen(),
        
      },
    );
  }
}
