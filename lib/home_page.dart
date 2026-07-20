import 'package:flutter/material.dart';

import 'cart_entry.dart';
import 'cart_page.dart';
import 'hardcoded_products.dart';
import 'item.dart';
import 'product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<item> _favorites = [];
  final List<CartEntry> _cartItems = [];

  void _addToCart(item i, String size) {
    setState(() {
      final matchIndex = _cartItems.indexWhere(
        (entry) => entry.product == i && entry.size == size,
      );
      if (matchIndex != -1) {
        _cartItems[matchIndex].quantity++;
      } else {
        _cartItems.add(CartEntry(product: i, size: size));
      }
    });
  }

  void _toggleFavorite(item i) {
    setState(() {
      if (_favorites.contains(i)) {
        _favorites.remove(i);
      } else {
        _favorites.add(i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset('assets/images/img.png'),
        ),
        title: const Text(
          'Shoeify',
          style: TextStyle(
            fontSize: 34,
            fontFamily: 'Sans_Serif',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [buildCartIcon(cartItems: _cartItems)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildFeatureItemsTxt(),
            buildFeatureList(),
            buildProductTxt(),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(12.0),
              childAspectRatio: 0.85,
              children: items.map((i) {
                return Product(
                  prod: i,
                  onAddToCart: _addToCart,
                  image: i.imageUrl,
                  isFavorited: _favorites.contains(i),
                  onToggleFavorite: () => _toggleFavorite(i),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildFeatureList() {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: featured.length,
          itemBuilder: (context, index) {
            final i = featured[index];
            return Padding(
              padding: EdgeInsets.all(4),
              child: SizedBox(
                width: 200,
                child: Product(
                  prod: i,
                  onAddToCart: _addToCart,
                  image: i.imageUrl,
                  isFavorited: _favorites.contains(i),
                  onToggleFavorite: () => _toggleFavorite(i),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Align buildFeatureItemsTxt() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: const Text(
          'Featured Items',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class buildProductTxt extends StatelessWidget {
  const buildProductTxt({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: const Text(
          'Products',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class buildCartIcon extends StatelessWidget {
  const buildCartIcon({super.key, required List<CartEntry> cartItems})
    : _cartItems = cartItems;

  final List<CartEntry> _cartItems;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(cartItems: _cartItems),
              ),
            );
          },
        ),
        if (_cartItems.isNotEmpty)
          Positioned(
            right: 6,
            top: 2,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Text(
                '${_cartItems.fold(0, (sum, entry) => sum + entry.quantity)}',
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
