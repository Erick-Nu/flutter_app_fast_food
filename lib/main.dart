import 'package:flutter/material.dart';
import 'src/screens/base_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Widget: MaterialApp — Uso: Contenedor raíz de la app, tema y home.
      title: 'Fast Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BaseScreen(), // Widget: BaseScreen — Uso: Pantalla raíz con navegación inferior.
    );
  }
}