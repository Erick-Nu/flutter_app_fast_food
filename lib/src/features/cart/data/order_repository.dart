import '../../../core/config/supabase_client.dart';
import '../../../core/utils/logger.dart';
import '../domain/entities/cart_item.dart';
import 'models/order_model.dart';
import 'models/order_detail_model.dart';

class OrderRepository {
  // Guardar un pedido completo
  Future<bool> createOrder({
    required String userId,
    required double total,
    required List<CartItem> items,
  }) async {
    try {
      // 1. Insertar la CABECERA del pedido
      // ADAPTADO A TU SQL: Usamos 'precio_total' y estado 'recibido'
      final orderResponse = await SupabaseConfig.client
          .from('pedidos')
          .insert({
            'usuario_id': userId,
            'precio_total': total, // <--- Antes era 'total', ahora coincide con tu tabla
            'estado': 'recibido',  // <--- Antes 'pendiente', ahora coincide con tu CHECK constraint
          })
          .select()
          .single();

      final String orderId = orderResponse['id'];
      
      // Intentamos obtener el código generado (ORD-1, ORD-2) para mostrarlo en el log
      final String orderCode = orderResponse['codigo_orden'] ?? 'SIN-CODIGO';
      logger.i('Pedido creado: $orderCode (ID: $orderId)');

      // 2. Preparar los DETALLES
      final List<Map<String, dynamic>> orderDetails = items.map((item) {
        return {
          'pedido_id': orderId,
          'producto_id': item.product.id,
          'cantidad': item.quantity,
          'precio_unitario': item.product.price,
        };
      }).toList();

      // 3. Insertar los DETALLES en lote
      await SupabaseConfig.client
          .from('detalle_pedido')
          .insert(orderDetails);

      logger.i('Detalles guardados correctamente');
      return true;

    } catch (e) {
      logger.e('Error creando pedido', error: e);
      return false;
    }
  }

  Future<List<OrderModel>> getOrders(String userId) async {
    try {
      final response = await SupabaseConfig.client
          .from('pedidos')
          .select()
          .eq('usuario_id', userId)
          .order('fecha', ascending: false); // Los más recientes primero

      // Convertimos la lista de mapas a lista de objetos
      final List<dynamic> data = response;
      return data.map((json) => OrderModel.fromJson(json)).toList();
      
    } catch (e) {
      logger.e('Error obteniendo pedidos', error: e);
      return []; // Si falla, devolvemos lista vacía
    }
  }

  Future<List<OrderDetailModel>> getOrderDetails(String orderId) async {
    try {
      // Magia de Supabase: '*, productos(*)' significa:
      // "Traeme todo de detalle_pedido Y todo de la tabla productos relacionada"
      final response = await SupabaseConfig.client
          .from('detalle_pedido')
          .select('*, productos(*)') 
          .eq('pedido_id', orderId);

      final List<dynamic> data = response;
      return data.map((json) => OrderDetailModel.fromJson(json)).toList();

    } catch (e) {
      logger.e('Error obteniendo detalles del pedido', error: e);
      return [];
    }
  }
}