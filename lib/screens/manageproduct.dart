import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement_3a/models/product.dart';
import 'package:statemanagement_3a/providers/productsprovider.dart';

class ManageProductScreen extends StatefulWidget {
  ManageProductScreen({
    super.key,
    this.index,
  });

  int? index;

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  var codeController = TextEditingController();

  var nameController = TextEditingController();

  var priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // codeController.text = widget.product?.code ?? '';
    // nameController.text = widget.product?.nameDesc ?? '';
    // priceController.text = widget.product?.price.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<Products>(context);
    Product? product;
    if (widget.index != null) {
      product = productProvider.item(widget.index!);
    }
    codeController.text = product?.code ?? '';
    nameController.text = product?.nameDesc ?? '';
    priceController.text = product?.price.toString() ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == null ? 'Add Product' : 'Edit Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            readOnly: widget.index != null,
            controller: codeController,
            decoration: const InputDecoration(
                label: Text('Code'), border: OutlineInputBorder()),
          ),
          const Gap(8),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
                label: Text('Name/Desc'), border: OutlineInputBorder()),
          ),
          const Gap(8),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(
                label: Text('Price'), border: OutlineInputBorder()),
          ),
          ElevatedButton(
            onPressed: () {
              var p = Product(
                code: codeController.text,
                nameDesc: nameController.text,
                price: double.parse(priceController.text),
              );
              if (widget.index == null) {
                productProvider.add(p);
              } else {
                productProvider.update(p, widget.index!);
              }
              Navigator.of(context).pop();
            },
            child: Text(widget.index == null ? 'ADD' : 'EDIT'),
          )
        ],
      ),
    );
  }
}
