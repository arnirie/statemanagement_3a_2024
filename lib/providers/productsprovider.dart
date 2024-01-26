import 'package:flutter/material.dart';
import 'package:statemanagement_3a/models/product.dart';

class Products extends ChangeNotifier {
  List<Product> _items = [
    // Product(code: 'code', nameDesc: 'nameDesc', price: 500),
  ];

  // List<Product> get items{
  //   return _items;
  // }

  List<Product> get items => _items;

  int get totalNoItems => _items.length;

  void add(Product p) {
    _items.add(p);
    notifyListeners();
  }

  void update(Product p, int index) {
    _items[index] = p;
    notifyListeners();
  }

  void toggleFavorite(int index) {
    _items[index].isFavorite = !_items[index].isFavorite;
    notifyListeners();
  }

  Product item(int index) => _items[index];
}
