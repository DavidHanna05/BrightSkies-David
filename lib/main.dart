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
class item{ // To create an item list of the hard coded items
  final String name;
  final int price;
  final String? tag;
  final int? discountPercent;
  const item({required this.name, required this.price, this.tag,this.discountPercent,});
}

class ProductDetailPage extends StatefulWidget {
  final item prod;
  final String image;
  final Function(item, String size) onAddToCart;
  const ProductDetailPage({
    super.key,
    required this.prod,
    required this.image,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;

  final List<String> sizes = ['40', '41', '42', '43', '44'];

  @override
  Widget build(BuildContext context) {
    final details = [
      'Brand: Nike',
      'Price: ${widget.prod.price} USD',
    ];

    return Scaffold(
      appBar: AppBar(title: Text(widget.prod.name),centerTitle: true),
      body: Column(
        children: [
          Image.network(
            widget.image,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),

          ListView.builder(               // no Expanded
            shrinkWrap: true,             // size to content instead of filling space
            physics: const NeverScrollableScrollPhysics(), // don't scroll independently
            itemCount: details.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8.0),
                child: Text(details[index], style: const TextStyle(fontSize: 16)),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select size:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: sizes.map((size) {
                  final isSelected = selectedSize == size;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ChoiceChip(
                      label: Text(size),
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
              onPressed: selectedSize == null
                  ? null
                  : () {
                widget.onAddToCart(widget.prod, selectedSize!); // now passes its OWN selected size
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added size $selectedSize to cart')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
