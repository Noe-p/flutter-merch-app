import 'package:flutter/material.dart';
import '../types/Cart.dart';

class CartProduct extends StatefulWidget {
  const CartProduct(
      {super.key,
      required this.cart,
      required this.decrementQuantity,
      required this.incrementQuantity});
  final Cart cart;
  final VoidCallback decrementQuantity;
  final VoidCallback incrementQuantity;

  @override
  State<CartProduct> createState() =>
      _CartProductState(cart, decrementQuantity, incrementQuantity);
}

class _CartProductState extends State<CartProduct> {
  _CartProductState(this.cart, this.decrementQuantity, this.incrementQuantity);
  var numberArticles = 2;
  final Cart cart;
  final VoidCallback decrementQuantity;
  final VoidCallback incrementQuantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                cart.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('${cart.price} €')),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      tooltip: 'Remove a product',
                      onPressed: () {
                        if (numberArticles > 0) {
                          setState(() {
                            numberArticles = numberArticles - 1;
                          });
                          decrementQuantity();
                        }
                      },
                    ),
                    Text('$numberArticles', style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      tooltip: 'Add a product',
                      onPressed: () {
                        setState(() {
                          numberArticles = numberArticles + 1;
                        });
                        incrementQuantity();
                      },
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('${cart.price * numberArticles} €',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}
