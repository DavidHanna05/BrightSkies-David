import 'item.dart';

final List<item> items = [
  item(
    name: 'Air Forces',
    price: 125,
    tag: 'Best Seller',
    imageUrl:
        'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?q=80&w=930&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  item(
    name: 'Air Maxes',
    price: 200,
    discountPercent: 20,
    imageUrl:
        'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?q=80&w=1325&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  item(
    name: 'Air 97s',
    price: 250,
    imageUrl:
        'https://images.unsplash.com/photo-1556878882-55e3e222a1fc?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  item(
    name: 'Travis',
    price: 1000,
    imageUrl:
        'https://images.unsplash.com/photo-1710668903629-9bfa9ae27968?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  item(
    name: 'Yeezy',
    price: 250,
    brand: 'Adidas',
    imageUrl:
        'https://images.unsplash.com/photo-1551489186-cf8726f514f8?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  item(
    name: 'Jordan 4',
    price: 300,
    imageUrl:
        'https://media.gq.com/photos/68d6ff16157709547c4cfee7/master/w_1600,c_limit/1%20(3).png',
  ),
];
List<item> featured = items.sublist(1, 5);
