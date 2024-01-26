import 'package:flutter/material.dart';
import 'package:statemanagement_3a/models/product.dart';

class CartItems extends ChangeNotifier {
  List<Product> _items = [];
}
