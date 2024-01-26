class Product {
  final String code;
  final String nameDesc;
  final double price;
  bool isFavorite;

  Product({
    required this.code,
    required this.nameDesc,
    required this.price,
    this.isFavorite = false,
  });
}
