import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'orders_screen.dart'; // Asegúrate de tener este archivo creado

// --- COLORES DE LA MARCA ---
const Color kPrimaryColor = Color(0xFFD32F2F); // Rojo Pizzería

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  // Lista de pantallas
  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    OrdersScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El body mantiene el estado de la pantalla seleccionada
      body: _screens.elementAt(_selectedIndex),
      
      // Envolvemos en un Theme para personalizar al máximo la barra
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // Fondo de la barra
          backgroundColor: Colors.white,
          
          // Color del indicador (la pastilla que rodea el icono seleccionado)
          indicatorColor: kPrimaryColor.withValues(alpha: 0.1),
          
          // Estilo del texto (Labels)
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.bold, 
                  color: kPrimaryColor
                );
              }
              return const TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.w500, 
                color: Colors.grey
              );
            },
          ),
          
          // Color de los iconos
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: kPrimaryColor, size: 26);
              }
              return const IconThemeData(color: Colors.grey, size: 24);
            },
          ),
        ),
        
        child: NavigationBar(
          height: 65, // Altura cómoda y moderna
          elevation: 5, // Sombra sutil en la parte superior
          shadowColor: Colors.black12,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: Colors.white, // Aseguramos fondo blanco
          surfaceTintColor: Colors.white, // Evita tinte al hacer scroll
          
          // Comportamiento de las etiquetas: siempre visibles para claridad
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined), // Icono más "tienda"
              selectedIcon: Icon(Icons.storefront),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long),
              label: 'Pedidos',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined), // Bolsa en vez de carrito (más moderno)
              selectedIcon: Icon(Icons.shopping_bag),
              label: 'Carrito',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}