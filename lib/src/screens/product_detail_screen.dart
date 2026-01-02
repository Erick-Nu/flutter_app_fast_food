import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/product/domain/entities/product_entity.dart';
import '../features/cart/presentation/providers/cart_provider.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);
const Color kTextColor = Color(0xFF333333);
const Color kWhiteColor = Colors.white;

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                stretch: true,
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kWhiteColor.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Hero(
                    tag: widget.product.name,
                    child: Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  transform: Matrix4.translationValues(0, -20, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: kTextColor,
                                  height: 1.1,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "\$${widget.product.price}",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            _InfoChip(icon: Icons.star, color: Colors.amber, label: "${widget.product.rating}"),
                            const SizedBox(width: 15),
                            const _InfoChip(icon: Icons.timer_outlined, color: Colors.blue, label: "25-30 min"),
                            const SizedBox(width: 15),
                            const _InfoChip(icon: Icons.local_fire_department, color: Colors.orange, label: "350 kcal"),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text("Descripción", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
                        const SizedBox(height: 10),
                        Text(
                          widget.product.description,
                          style: TextStyle(color: Colors.grey[600], height: 1.6, fontSize: 15),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: kWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 20, color: kTextColor),
                          onPressed: () {
                            if (_quantity > 1) setState(() => _quantity--);
                          },
                        ),
                        Text(
                          "$_quantity",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 20, color: kTextColor),
                          onPressed: () {
                            setState(() => _quantity++);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: kWhiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          final cartProvider = Provider.of<CartProvider>(context, listen: false);

                          for (int i = 0; i < _quantity; i++) {
                            cartProvider.addToCart(widget.product);
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle, color: kWhiteColor),
                                  const SizedBox(width: 10),
                                  Text("¡Agregaste $_quantity x ${widget.product.name}!"),
                                ],
                              ),
                              backgroundColor: Colors.green[600],
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              duration: const Duration(seconds: 2),
                            ),
                          );

                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Agregar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: kWhiteColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "\$${(widget.product.price * _quantity).toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _InfoChip({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: kTextColor, fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}