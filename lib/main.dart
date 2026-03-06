import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const JordanTourismApp());
}

class JordanTourismApp extends StatelessWidget {
  const JordanTourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Cairo',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryAmber,
            foregroundColor: AppConstants.primaryBrown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}