import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
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
      body: _screens.elementAt(_selectedIndex),
      
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // Texto más pequeño para que quepa en 50px
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
          // Iconos ligeramente reducidos
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(size: 22),
          ),
        ),
        child: NavigationBar(
          height: 60, // Altura compacta
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          
          // Corrección: Usamos withValues en lugar de withOpacity
          indicatorColor: Colors.deepPurple.withAlpha(25),
          
          // Muestra siempre el texto (puedes cambiar a onlyShowSelected si prefieres)
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
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