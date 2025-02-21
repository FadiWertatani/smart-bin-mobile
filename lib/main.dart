import 'package:flutter/material.dart';
import 'package:smar_bin/modules/onBoarding/OnBoarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff589FB6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff589FB6),
          primary: const Color(0xff589FB6),
          secondary: const Color(0xff76B4C0),
        ),
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      home: OnboardingScreen(),
    );
  }
}