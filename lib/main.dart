import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/planning.dart';


void main() {
  runApp(const TripMateApp());
}

class TripMateApp extends StatelessWidget {
  const TripMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFDC2626)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoardingScreen(),
        // '/login': (context) => const LoginScreen(),
        // '/signup': (context) => const SignupScreen(),
        '/planning': (context) => const PlanningScreen(),
      },
    );
  }
}
