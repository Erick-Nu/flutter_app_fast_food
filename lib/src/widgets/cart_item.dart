import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kTextColor = Color(0xFF333333);
const Color kBackgroundColor = Color(0xFFF2F2F2);

class CartItem extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const CartItem({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    this.onAdd,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = imageUrl.startsWith('http');
    
    double unitPrice = 0.0;
    try {
      unitPrice = double.parse(price.replaceAll(RegExp(r'[^0-9.]'), ''));
    } catch (_) {}
    final subtotal = unitPrice * quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20, 
            offset: const Offset(0, 5)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: IntrinsicHeight( // Truco Pro: Ajusta la altura al contenido más alto
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 100, // Un poco más grande para que luzca
                  height: 100,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      isNetworkImage
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[100], child: const Icon(Icons.broken_image, color: Colors.grey)),
                            )
                          : Image.asset(
                              imageUrl, 
                              fit: BoxFit.cover, 
                              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[100], child: const Icon(Icons.image_not_supported, color: Colors.grey))
                            ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye verticalmente
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: kTextColor,
                        height: 1.2
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    Text(
                      "Unitario: $price",
                      style: TextStyle(
                        fontSize: 12, 
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              _QuantityBtn(icon: Icons.remove, onTap: onRemove),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: kTextColor),
                                ),
                              ),
                              _QuantityBtn(icon: Icons.add, onTap: onAdd, isAdd: true),
                            ],
                          ),
                        ),
                        
                        Text(
                          "\$${subtotal.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.w900, 
                            color: kPrimaryColor
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _QuantityBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isAdd;

  const _QuantityBtn({required this.icon, this.onTap, this.isAdd = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 32,
          height: 36,
          child: Icon(
            icon, 
            size: 16, 
            color: isAdd ? kPrimaryColor : Colors.grey[700]
          ),
        ),
      ),
    );
  }
  
}