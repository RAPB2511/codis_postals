import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'styles/app_styles.dart';

// Punt d'entrada de l'aplicació
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codis Postals',
      debugShowCheckedModeBanner: false, // Trec la cinta de debug
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: AppStyles.backgroundColor,
      ),
      home: const HomeScreen(), // La pantalla principal arrenca aquí
    );
  }
}
