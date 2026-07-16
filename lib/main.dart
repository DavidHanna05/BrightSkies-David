import 'package:flutter/material.dart';

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

  void _addToCart() {
    setState(() {
      _cartCount++;
    });
  }

  @override
  Widget build(BuildContext context) {

    final items= [const item(name:'Air Forces', price:125),
      const item(name:'Air Maxes',price:200),
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
          Product(prod: items[0], onAddToCart: _addToCart,image:'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?q=80&w=930&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)'),
          Product(prod: items[1], onAddToCart: _addToCart,image:'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?q=80&w=1325&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          Product(prod: items[2], onAddToCart: _addToCart,image:'https://images.unsplash.com/photo-1556878882-55e3e222a1fc?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          Product(prod: items[3], onAddToCart: _addToCart,image:'https://images.unsplash.com/photo-1710668903629-9bfa9ae27968?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        ],
      ),);}
  }
class Product extends StatelessWidget{
  final item prod;
  final VoidCallback onAddToCart; //This is to be able to update the shopping cart count
  final String image;
  const Product({super.key,required this.prod, required this.onAddToCart,required this.image});

  Widget build(BuildContext context) {
    return Card(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(prod: prod, image: image,onAddToCart: onAddToCart,),
              ),
            );
          },
          child: Image.network(
            image,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Text(prod.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('${prod.price} USD'),
        ElevatedButton(
          onPressed: onAddToCart, //when pressed the funtion will call in the _MyHomePage and increment the count
          child: const Text('Add to Cart'),
        ),
      ],
    ),);
  }
}
class item{ // To create an item list of the hard coded items
  final String name;
  final int price;
  const item({required this.name, required this.price});// curly braces to maintain order of constructor inputs to maintain safety and consistency
}
class ProductDetailPage extends StatelessWidget {
  final item prod;
  final String image;
  final VoidCallback onAddToCart;
  const ProductDetailPage({super.key, required this.prod, required this.image, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    // Mock detail data — swap for real info later
    final details = [
      'Brand: Nike',
      'Type: ${prod.name}',
      'Price: ${prod.price} USD',
      'Available sizes: 40, 41, 42, 43, 44',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(prod.name),
      ),
      body: Column(
        children: [
          Image.network(
            image,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: details.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    details[index],
                    style: const TextStyle(fontSize: 16),
                  ),

                );
              },
            ),
          ),
      Padding(
        padding: const EdgeInsets.all(60.0),
        child: ElevatedButton(
          onPressed: onAddToCart,
          child: const Text('Add to Cart'),
        ),),
        ],
      ),
    );
  }
}