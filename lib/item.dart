class item{ // To create an item list of the hard coded items
  final String name;
  final int price;
  final String? tag;
  final int? discountPercent;
  final double rating;
  const item({required this.name, required this.price, this.tag,this.discountPercent,this.rating = 0,});
}