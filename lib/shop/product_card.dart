import 'package:flutter/material.dart';

import '../types/Product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key, required this.product, required this.onCartPressed});
  final Product product;
  final VoidCallback onCartPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Image(
            image: NetworkImage(product.image),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
        ),
        Container(
          padding: EdgeInsets.all(6),
          child: Text(
            product.category,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          padding: EdgeInsets.all(6),
          child: product.title.length > 20
              ? Text('${product.title.substring(0, 20)}...',
                  style: TextStyle(fontWeight: FontWeight.bold))
              : Text(product.title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.all(6),
          child: Row(
            children: List.generate(5, (index) {
              return Icon(
                index < product.rating.floor() ? Icons.star : Icons.star_border,
                color: Colors.black,
              );
            }),
          ),
        ),
        Container(
          padding: EdgeInsets.all(6),
          child: Text(product.description, textAlign: TextAlign.left),
        ),
        Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.price} €',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  tooltip: 'Add to cart',
                  onPressed: () {
                    onCartPressed();
                  },
                ),
              ],
            ))
      ],
    ));
  }
}
