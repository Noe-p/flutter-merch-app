class Product {
  final String title;
  final String category;
  final String description;
  final double price;
  final double rating;
  final String image;
  const Product(
      {required this.title,
      required this.category,
      required this.description,
      required this.price,
      required this.rating,
      required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      image: json['images'][0],
    );
  }
}
