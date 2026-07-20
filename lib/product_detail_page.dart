import 'package:flutter/material.dart';

import 'item.dart';

class ProductDetailPage extends StatefulWidget {
  final item prod;

  final Function(item, String size) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.prod,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  int? userRating;
  final List<String> sizes = ['40', '41', '42', '43', '44'];

  @override
  Widget build(BuildContext context) {
    final details = [
      'Brand: ${widget.prod.brand}',
      'Price: ${widget.prod.price} USD',
    ];

    return Scaffold(
      appBar: AppBar(title: Text(widget.prod.name), centerTitle: true),
      body: Column(
        children: [
          Image.network(
            widget.prod.imageUrl,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),

          ListView.builder(
            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            itemCount: details.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                child: Text(
                  details[index],
                  style: const TextStyle(fontSize: 20),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                ...List.generate(5, (index) {
                  //el ... beymap el generated widgets fel row
                  return Icon(
                    index < widget.prod.rating.round()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  );
                }),
                const SizedBox(width: 8),
                Text(
                  '${widget.prod.rating.toStringAsFixed(1)} average',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          // User's own rating — tappable
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your rating:',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 20),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          userRating = index + 1;
                        });
                      },
                      child: Icon(
                        index < (userRating ?? 0)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                    );
                  }),
                ),
                if (userRating != null)
                  Text(
                    'You rated this $userRating star${userRating == 1 ? '' : 's'}',
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select size:',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: sizes.map((size) {
                  final isSelected = selectedSize == size;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ChoiceChip(
                      label: Text(
                        size,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: isSelected,
                      shape: const StadiumBorder(),
                      onSelected: (selected) {
                        setState(() {
                          selectedSize = selected ? size : null;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
              ),
              onPressed: selectedSize == null
                  ? null
                  : () {
                      widget.onAddToCart(
                        widget.prod,
                        selectedSize!,
                      ); // now passes its OWN selected size
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added size $selectedSize to cart'),
                        ),
                      );
                    },
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
