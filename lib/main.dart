import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme,
      darkTheme: DarkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(), 
    ); 
  }
}