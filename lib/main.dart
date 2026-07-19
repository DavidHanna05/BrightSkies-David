import 'package:flutter/material.dart';
import 'item.dart';
import 'product.dart';
import 'product_detail_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _cartCount = 0;
  final List<item> _favorites = [];
  void _addToCart(item i, String size) {
    setState(() {
      _cartCount++; // or, once you build the cart page, add to _cartItems here instead
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

    final items= [const item(name:'Air Forces', price:125, tag:'Best Seller'),
      const item(name:'Air Maxes',price:200, discountPercent: 20),
      const item(name:'Air 97s',price:250),
      const item (name:'Travis', price: 1000)];
    return Scaffold(
        appBar: AppBar(leading: Padding(padding: const EdgeInsets.all(2.0),
          child: Image.asset('assets/images/img.png'),),
          title: const Text('Damazon',
            style: TextStyle(
              fontSize: 34,
              fontFamily: 'Sans_Serif',
              fontWeight: FontWeight.bold,
            ),),
          centerTitle: true,
          actions:[Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 6,
                  top: 2,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '$_cartCount',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          ],
        ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(12.0),
        childAspectRatio: 0.6,
        children: [
          Product(prod: items[0], onAddToCart: _addToCart,image:'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?q=80&w=930&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)', isFavorited: _favorites.contains(items[0]),
            onToggleFavorite: () => _toggleFavorite(items[0]),),
          Product(prod: items[1], onAddToCart: _addToCart,image:'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?q=80&w=1325&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', isFavorited: _favorites.contains(items[1]),
            onToggleFavorite: () => _toggleFavorite(items[1]),),
          Product(prod: items[2], onAddToCart: _addToCart,image:'https://images.unsplash.com/photo-1556878882-55e3e222a1fc?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', isFavorited: _favorites.contains(items[2]),
      onToggleFavorite: () => _toggleFavorite(items[2]),),
          Product(prod: items[3], onAddToCart: _addToCart,image:'https://images.unsplash.com/photo-1710668903629-9bfa9ae27968?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', isFavorited: _favorites.contains(items[3]),
            onToggleFavorite: () => _toggleFavorite(items[3]),),
        ],
      ),);}
  }