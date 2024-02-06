import 'package:bw2/screens/about_screen.dart';
import 'package:bw2/screens/home_screen.dart';
import 'package:bw2/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF015492);
    return MaterialApp(
      title: 'InaWAS',
      theme: ThemeData(
        primaryColor: primaryColor, // Set primary color
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
