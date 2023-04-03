import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';

import './product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3.4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(
                  // products[i].id,
                  // products[i].title,
                  // products[i].imageUrl,
                  ),
            ));
  }
}
