import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement_3a/models/product.dart';
import 'package:statemanagement_3a/providers/productsprovider.dart';
import 'package:statemanagement_3a/screens/manageproduct.dart';

class ViewProductsScreen extends StatelessWidget {
  void openAddScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ManageProductScreen(),
      ),
    );
  }

  void openEditScreen(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ManageProductScreen(index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var prodProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
        actions: [
          IconButton(
            onPressed: () => openAddScreen(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<Products>(
        builder: (_, products, _c) {
          return ListView.builder(
            itemBuilder: (_, index) => Card(
              child: ListTile(
                onTap: () => openEditScreen(context, index),
                leading: IconButton(
                  onPressed: () {
                    prodProvider.toggleFavorite(index);
                  },
                  icon: Icon(products.items[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_outline),
                ),
                title: Text(products.items[index].nameDesc),
              ),
            ),
            itemCount: products.totalNoItems,
          );
        },
      ),
    );
  }
}
