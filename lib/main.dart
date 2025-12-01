import 'package:flutter/material.dart';
import 'src/screens/base_screen.dart'; // Importa la nueva base

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Food App',
      // Quitamos la etiqueta de "Debug" de la esquina (opcional)
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BaseScreen(), // <-- Cambio aquí
    );
  }
}