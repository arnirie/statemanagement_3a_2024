import 'package:statemanagement_3a/helpers/dbhelper.dart';

class Product {
  late String code;
  late String nameDesc;
  late double price;
  late bool isFavorite;

  Product({
    required this.code,
    required this.nameDesc,
    required this.price,
    this.isFavorite = false,
  });

  Product.fromMap(Map<String, dynamic> value) {
    code = value[DbHelper.prodCode];
    nameDesc = value[DbHelper.prodName];
    price = double.parse(value[DbHelper.prodPrice].toString());
    isFavorite = false;
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.prodCode: code,
      DbHelper.prodName: nameDesc,
      DbHelper.prodPrice: price,
    };
  }
}
