import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:merch_app/shop/product_card.dart';
import '../types/Product.dart';

Future<List<Product>> fetchProduct() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  if (response.statusCode == 200) {
    return List<Product>.from(
        json.decode(response.body)['products'].map((x) => Product.fromJson(x)));
  } else {
    throw Exception('Failed to load album');
  }
}

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key, required this.onCartPressed});
  final VoidCallback onCartPressed;

  @override
  Widget build(BuildContext context) {
    late Future<List<Product>> products = fetchProduct();

    return Center(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.5,
          ),
          primary: false,
          shrinkWrap: true,
          itemCount: 30,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ProductCard(
                      product: snapshot.data![index],
                      onCartPressed: onCartPressed);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            );
          }),
    );
  }
}
