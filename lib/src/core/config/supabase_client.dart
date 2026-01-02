import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../utils/logger.dart';

class SupabaseConfig {
  static late final String supabaseUrl;
  static late final String supabaseAnonKey;

  static Future<void> initialize() async {
    try {
      final url = dotenv.env['SUPABASE_URL'] ?? '';
      final anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

      if (url.isEmpty || anonKey.isEmpty) {
        throw Exception('Faltan variables de entorno en .env');
      }

      supabaseUrl = url;
      supabaseAnonKey = anonKey;

      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
      );

      logger.i(
        'SUPABASE INICIALIZADO CORRECTAMENTE\n'
        'URL: $url'
      );

    } catch (e) {
      logger.e(
        'ERROR CRÍTICO AL CONECTAR SUPABASE', 
        error: e,
      );
      rethrow; 
    }
  }

  static SupabaseClient get client => Supabase.instance.client;
}