import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement_3a/helpers/dbhelper.dart';
import 'package:statemanagement_3a/models/cartitem.dart';
import 'package:statemanagement_3a/models/product.dart';
import 'package:statemanagement_3a/providers/cartprovider.dart';
import 'package:statemanagement_3a/providers/productsprovider.dart';
import 'package:statemanagement_3a/screens/manageproduct.dart';
import 'package:statemanagement_3a/screens/viewcart.dart';

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

  void addToCart(BuildContext context, String pCode) {
    Provider.of<CartItems>(context, listen: false).add(
      CartItem(code: pCode),
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
          return FutureBuilder(
            future: products.items,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var productList = snapshot.data;
              print(productList);
              return ListView.builder(
                itemBuilder: (_, index) => Card(
                  child: ListTile(
                    onTap: () => openEditScreen(context, index),
                    leading: IconButton(
                      onPressed: () {
                        prodProvider.toggleFavorite(index);
                      },
                      icon: Icon(productList![index].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline),
                    ),
                    title: Text(productList[index].nameDesc),
                    trailing: IconButton(
                      onPressed: () =>
                          addToCart(context, productList[index].code),
                      icon: Icon(Icons.shopping_cart_outlined),
                    ),
                  ),
                ),
                itemCount: products.totalNoItems,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ViewCartScreen(),
          ),
        ),
        child: Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
}
