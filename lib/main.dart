import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'src/core/config/supabase_client.dart';
import 'src/core/config/injection.dart'; 
import 'src/screens/base_screen.dart';
import 'src/screens/login_screen.dart';

import 'src/features/product/presentation/providers/product_provider.dart';
import 'src/features/auth/presentation/providers/auth_provider.dart';
import 'src/features/cart/presentation/providers/cart_provider.dart';
import 'src/features/cart/presentation/providers/order_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");
  await initializeDateFormatting('es'); 
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
        ChangeNotifierProvider(
          lazy: false, 
          create: (_) => AuthProvider()..checkSession()
        ),
        ChangeNotifierProvider(
            lazy: false,
            create: (_) => ProductProvider()..loadPopularProducts()
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Fast Food App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD32F2F)),
          useMaterial3: true,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {

            if (authProvider.status == AuthStatus.checking) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
                ),
              );
            }

            if (authProvider.status == AuthStatus.authenticated) {
              return const BaseScreen();
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}