import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'orders_screen.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[HomeScreen(), OrdersScreen(), CartScreen(), ProfileScreen()];

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
          backgroundColor: Colors.white,
          indicatorColor: kPrimaryColor.withValues(alpha: 0.1),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kPrimaryColor);
            }
            return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey);
          }),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: kPrimaryColor, size: 26);
            }
            return const IconThemeData(color: Colors.grey, size: 24);
          }),
        ),
        child: NavigationBar(
          height: 65,
          elevation: 5,
          shadowColor: Colors.black12,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Inicio'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Pedidos'),
            NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), selectedIcon: Icon(Icons.shopping_bag), label: 'Carrito'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
