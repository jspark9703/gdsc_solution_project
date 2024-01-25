import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/firebase_options.dart';
import 'package:gdsc_solution_project/screens/login_screen.dart';
import 'package:gdsc_solution_project/screens/register_screen.dart';
import 'package:gdsc_solution_project/screens/search_screen.dart';
import 'package:gdsc_solution_project/screens/selcet_price_screen.dart';
import 'package:gdsc_solution_project/screens/select_button_screen.dart';
import 'package:gdsc_solution_project/screens/select_category_screen.dart';
import 'package:gdsc_solution_project/screens/select_filter_screen.dart';
import 'package:gdsc_solution_project/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
  ],
);

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
        "/": (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/reg': (context) => RegisterScreen(),
        '/search': (context) => SearchScreen(),
        '/search/select_button_screen': (context) => SelectButtonScreen(),
        '/search/select_filter_screen': (context) => SelectFilterScreen(),
        '/search/select_filter_screen/price': (context) => SelectPriceScreen(),
        '/search/select_filter_screen/category': (context) =>
            SelectCategoryScreen(),
      },
    );
  }
}
