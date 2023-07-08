class Cart {
  final int id;
  final String title;
  final int price;
  final int quantity;
  final int total;

  const Cart({
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.id,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      quantity: json['quantity'],
      total: json['total'],
    );
  }
}
