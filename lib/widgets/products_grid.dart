import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';

import './product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3.4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i) => ChangeNotifierProvider(
              create: (c) => products[i],
              child: ProductItem(
                  // products[i].id,
                  // products[i].title,
                  // products[i].imageUrl,
                  ),
            ));
  }
}
