import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // 0 para no imprimir el stacktrace en mensajes simples
    errorMethodCount: 5, // Cuántas líneas mostrar si hay error
    lineLength: 50, // Ancho de la línea
    colors: true, // Colores en consola (iOS/Android/VSCode)
    printEmojis: true, // Emojis
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);