class User {
  final String firstName;
  final String lastName;
  final String pseudo;
  final String phone;
  final String email;
  final String address;
  final String postalCode;
  final String city;
  final String image;

  const User(
      {required this.firstName,
      required this.lastName,
      required this.pseudo,
      required this.phone,
      required this.email,
      required this.address,
      required this.postalCode,
      required this.image,
      required this.city});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        pseudo: json['maidenName'],
        phone: json['phone'],
        email: json['email'],
        address: json['address']['address'],
        postalCode: json['address']['postalCode'],
        city: json['address']['city'],
        image: json['image']);
  }
}
