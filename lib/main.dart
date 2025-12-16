// Archivo: lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart'; // <--- ¿Tienes este import?

import 'src/core/config/supabase_client.dart';
import 'src/core/config/injection.dart'; 
import 'src/features/product/presentation/providers/product_provider.dart';
import 'src/screens/base_screen.dart';

import 'src/features/auth/presentation/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseConfig.initialize();
  await initInjection(); // <--- 1. IMPORTANTE: ¿Está esta línea?

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. IMPORTANTE: MultiProvider envuelve a MaterialApp
    return MultiProvider(
      providers: [
        // 3. LA CLAVE ESTÁ AQUÍ 👇
        // Fíjate en los dos puntos ".." antes de loadPopularProducts()
        ChangeNotifierProvider(
            lazy: false,
            create: (_) => ProductProvider()..loadPopularProducts()
        ),
        ChangeNotifierProvider(
          lazy: false, // Queremos que verifique la sesión apenas arranque
          create: (_) => AuthProvider()..checkSession()
        ),
      ],
      child: MaterialApp(
        title: 'Fast Food App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD32F2F)),
          useMaterial3: true,
        ),
        home: const BaseScreen(),
      ),
    );
  }
}