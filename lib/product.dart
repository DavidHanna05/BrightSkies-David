
import 'package:flutter/material.dart';
import 'item.dart';               // Product needs the item class
import 'product_detail_page.dart';
class Product extends StatefulWidget { // needs to become Stateful now
  final item prod;
  final Function(item, String size) onAddToCart; // now needs the size passed along
  final String image;
  final bool isFavorited;
  final VoidCallback onToggleFavorite;

  const Product({
    super.key,
    required this.prod,
    required this.onAddToCart,
    required this.image,
    required this.isFavorited,
    required this.onToggleFavorite,
  });

  @override
  State<Product> createState() => _ProductState();
}
class _ProductState extends State<Product> {
  String? selectedSize;
  bool justAdded = false;
  int? userRating;
  final List<String> sizes = ['40', '41', '42', '43', '44','45',];
  void _handleAddToCart() {
    widget.onAddToCart(widget.prod, selectedSize!);
    setState(() {
      justAdded = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) { // see explanation below
        setState(() {
          justAdded = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        prod: widget.prod,
                        image: widget.image,
                        onAddToCart: widget.onAddToCart,
                      ),
                    ),
                  );
                },
                child: Image.network(widget.image, width: double.infinity, height: 150, fit: BoxFit.cover),
              ),
              if (widget.prod.tag != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                    child: Text(widget.prod.tag!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                )
              else if (widget.prod.discountPercent != null)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.orangeAccent, borderRadius: BorderRadius.circular(20)),
                    child: Text('${widget.prod.discountPercent}% OFF', style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              Positioned( // ← restored: this is the favorite icon, separate from the navigation logic
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: widget.onToggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      widget.isFavorited ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: widget.isFavorited ? Colors.red : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(widget.prod.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            alignment: WrapAlignment.center,
            children: sizes.map((size) {
              return ChoiceChip(
                label: Text(size, style: const TextStyle(fontSize: 11)),
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact, // keeps chips small on a crowded card
                selected: selectedSize == size,
                onSelected: (isSelected) {
                  setState(() {
                    selectedSize = isSelected ? size : null;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 4),
          if (widget.prod.discountPercent != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.prod.price} USD',
                  style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(widget.prod.price * (100 - widget.prod.discountPercent!) / 100).round()} USD',
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            )
          else
            Text('${widget.prod.price} USD'),

          ElevatedButton(
            onPressed: (selectedSize == null || justAdded)
                ? null // disabled while no size picked, OR while showing "Added"
                : _handleAddToCart,
            child: Text(justAdded ? 'Added' : 'Add to Cart'),
          ),
        ],
      ),
    );
  }
}

