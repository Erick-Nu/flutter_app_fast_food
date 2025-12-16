import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../utils/logger.dart'; // <--- 1. Importamos nuestro logger

class SupabaseConfig {
  static Future<void> initialize() async {
    try {
      final url = dotenv.env['SUPABASE_URL'] ?? '';
      final anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

      if (url.isEmpty || anonKey.isEmpty) {
        throw Exception('Faltan variables de entorno en .env');
      }

      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
      );

      // 2. Usamos el logger para un mensaje de ÉXITO (Info) ℹ️
      logger.i(
        'SUPABASE INICIALIZADO CORRECTAMENTE\n'
        'URL: $url'
      );

    } catch (e) {
      // 3. Usamos el logger para un mensaje de ERROR (Fatal/Error)
      logger.e(
        'ERROR CRÍTICO AL CONECTAR SUPABASE', 
        error: e, // Pasamos el objeto error para que imprima detalles
      );
      rethrow; 
    }
  }

  static SupabaseClient get client => Supabase.instance.client;
}