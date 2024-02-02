import 'package:flutter/material.dart';
import 'package:statemanagement_3a/models/product.dart';
import 'package:statemanagement_3a/screens/manageproduct.dart';

class ViewProductsScreen extends StatefulWidget {
  ViewProductsScreen({super.key});

  @override
  State<ViewProductsScreen> createState() => _ViewProductsScreenState();
}

class _ViewProductsScreenState extends State<ViewProductsScreen> {
  List<Product> listProducts = [
    Product(
      code: 'code',
      nameDesc: 'nameDesc',
      price: 500,
    )
  ];

  void addProduct(Product p) {
    setState(() {
      listProducts.add(p);
    });
  }

  void editProduct(Product p, int index) {
    setState(() {
      // listProducts[index].nameDesc = p.nameDesc;
      // listProducts[index].price = p.price;
      listProducts[index] = p;
    });
  }

  void openAddScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ManageProductScreen(
            // add: addProduct,
            ),
      ),
    );
  }

  void openEditScreen(Product p, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ManageProductScreen(
          // edit: editProduct,
          // product: p,
          index: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
        actions: [
          IconButton(onPressed: openAddScreen, icon: Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => Card(
          child: ListTile(
            onTap: () => openEditScreen(listProducts[index], index),
            title: Text(listProducts[index].nameDesc),
          ),
        ),
        itemCount: listProducts.length,
      ),
    );
  }
}
