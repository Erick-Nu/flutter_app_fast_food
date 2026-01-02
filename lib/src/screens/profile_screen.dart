import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/cart/presentation/providers/order_provider.dart'; 
import '../widgets/profile_header.dart'; 
import '../screens/login_screen.dart';
import 'orders_screen.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);
const Color kTextColor = Color(0xFF333333);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, OrderProvider>(
      builder: (context, authProvider, orderProvider, child) {
        
        if (authProvider.status != AuthStatus.authenticated || authProvider.currentUser == null) {
          return const LoginScreen();
        }

        final user = authProvider.currentUser!;
        final ordersCount = orderProvider.orders.length.toString();

        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ProfileHeader(
                  name: user.name,
                  email: user.email,
                  level: user.levelName ?? 'Novato',
                ),

                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _StatItem(
                            value: ordersCount, 
                            label: "Pedidos", 
                            icon: Icons.receipt_long
                          ),
                          const _VerticalDivider(),
                          const _StatItem(
                            value: "3",
                            label: "Cupones", 
                            icon: Icons.local_offer_outlined
                          ),
                          const _VerticalDivider(),
                          _StatItem(
                            value: user.points.toString(), 
                            label: "Puntos", 
                            icon: Icons.star_border,
                            isPoints: true
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionHeader(title: "Mi Cuenta"),
                      
                      _ProfileMenuButton(
                        icon: Icons.shopping_bag_outlined,
                        text: "Mis Pedidos",
                        badgeCount: int.tryParse(ordersCount) ?? 0,
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const OrdersScreen())
                          );
                        },
                      ),
                      
                      _ProfileMenuButton(
                        icon: Icons.person_outline,
                        text: "Datos Personales",
                        onTap: () {}, 
                      ),
                      
                      _ProfileMenuButton(
                        icon: Icons.location_on_outlined,
                        text: "Direcciones de Entrega",
                        onTap: () {}, 
                      ),

                      const SizedBox(height: 25),
                      const _SectionHeader(title: "Configuración"),
                      
                      _ProfileMenuButton(
                        icon: Icons.notifications_none,
                        text: "Notificaciones",
                        onTap: () {},
                      ),
                      _ProfileMenuButton(
                        icon: Icons.help_outline,
                        text: "Ayuda y Soporte",
                        onTap: () {},
                      ),

                      const SizedBox(height: 35),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 40),
                        child: OutlinedButton.icon(
                          onPressed: () => authProvider.signOut(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            side: BorderSide(color: kPrimaryColor.withOpacity(0.5)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                            foregroundColor: kPrimaryColor,
                          ),
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text("Cerrar Sesión", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final bool isPoints;

  const _StatItem({
    required this.value, 
    required this.label, 
    required this.icon,
    this.isPoints = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 24, color: isPoints ? Colors.amber : Colors.grey[400]),
        const SizedBox(height: 8),
        Text(
          value, 
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w900, 
            color: isPoints ? kPrimaryColor : kTextColor
          )
        ),
        Text(
          label, 
          style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w600)
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40, color: Colors.grey[200]);
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text(
        title, 
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: kTextColor.withOpacity(0.8))
      ),
    );
  }
}

class _ProfileMenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final int badgeCount;

  const _ProfileMenuButton({
    required this.icon, 
    required this.text, 
    required this.onTap,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.08), borderRadius: BorderRadius.circular(15)),
                  child: Icon(icon, color: kPrimaryColor, size: 22),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: kTextColor)),
                ),
                if (badgeCount > 0)
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)),
                    child: Text("$badgeCount", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[300]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}