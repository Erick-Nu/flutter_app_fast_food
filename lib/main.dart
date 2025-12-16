// Archivo: lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart'; // <--- 1. Import necesario para las fechas

import 'src/core/config/supabase_client.dart';
import 'src/core/config/injection.dart'; 
import 'src/features/product/presentation/providers/product_provider.dart';
import 'src/screens/base_screen.dart';

import 'src/features/auth/presentation/providers/auth_provider.dart';
import 'src/features/cart/presentation/providers/cart_provider.dart';
import 'src/features/cart/presentation/providers/order_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Carga de variables de entorno
  await dotenv.load(fileName: ".env");

  // 2. IMPORTANTE: Inicializamos el formato de fechas en Español
  // Esto soluciona el error "LocaleDataException"
  await initializeDateFormatting('es'); 

  // Inicialización de servicios
  await SupabaseConfig.initialize();
  await initInjection(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider de Productos (Carga inicial)
        ChangeNotifierProvider(
            lazy: false,
            create: (_) => ProductProvider()..loadPopularProducts()
        ),
        // Provider de Autenticación (Verificación de sesión)
        ChangeNotifierProvider(
          lazy: false, 
          create: (_) => AuthProvider()..checkSession()
        ),
        // Provider del Carrito
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // Provider de Pedidos
        ChangeNotifierProvider(create: (_) => OrderProvider()),
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