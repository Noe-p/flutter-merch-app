import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:merch_app/cart/cart_product.dart';
import 'package:http/http.dart' as http;
import '../types/Cart.dart';
import 'dart:developer' as developer;

Future<List<Cart>> fetchCart() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/carts/1'));
  developer.log(response.body, name: 'my.app.category');

  if (response.statusCode == 200) {
    return List<Cart>.from(
        json.decode(response.body)['products'].map((x) => Cart.fromJson(x)));
  } else {
    throw Exception('Failed to load album');
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    late Future<List<Cart>> cart = fetchCart();
    var totalQuantity = 0;
    var totalPrice = 0;

    //Initialise state

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(8),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
              Text('Mon panier',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.end),
            ])),
        Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text('Total produits : $totalQuantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.start),
                  ],
                ),
                Row(children: [
                  Text('Total : $totalPrice €',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start),
                ]),
              ],
            )),
        Expanded(
          child: FutureBuilder<List<Cart>>(
            future: cart,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CartProduct(
                        cart: snapshot.data![index],
                        decrementQuantity: () {
                          setState(() {
                            totalQuantity = totalQuantity - 1;
                          });
                        },
                        incrementQuantity: () {
                          setState(() {
                            totalQuantity = totalQuantity + 1;
                          });
                        },
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
