import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';
import 'package:pembekalan_flutter/views/dashboardscreen.dart';
import 'package:pembekalan_flutter/views/loginscreen.dart';
import 'package:pembekalan_flutter/views/registerscreen.dart';
import 'package:pembekalan_flutter/views/splashscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // lock orientasi layar menjadi Portrait Up
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // untuk menghilangkan banner debug
      title: 'Pembekalan Flutter 2025',
      home: SplashScreen(),
      routes: {
        Routes.splashscreen: (context) => SplashScreen(),
        Routes.loginscreen: (context) => LoginScreen(),
        Routes.registerscreen: (context) => RegisterScreen(),
        Routes.dashboardscreen: (context) => DashboardScreen(),
        
      },
    );
  }
}
