import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:merch_app/types/User.dart';
import 'dart:developer' as developer;

Future<User> fetchUser() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/users/1'));
  developer.log(response.body, name: 'my.app.category');

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late Future<User> user = fetchUser();

    return Expanded(
        child: FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            child:
                                Image.network(snapshot.data!.image, scale: 2),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text('Mon compte',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30)),
                                  TextField(
                                    controller: TextEditingController(
                                        text: snapshot.data!.lastName),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Nom',
                                      hintText: 'John',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          height: 3),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  TextField(
                                    controller: TextEditingController(
                                        text: snapshot.data!.firstName),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Prénom',
                                      hintText: 'Doe',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          height: 3),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  TextField(
                                    controller: TextEditingController(
                                        text: snapshot.data!.pseudo),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Pseudo',
                                      hintText: 'Jodo',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          height: 3),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ))
                        ])),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: TextEditingController(
                                  text: snapshot.data!.phone),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Téléphone',
                                hintText: '+33102030405',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    height: 3),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            TextField(
                              controller: TextEditingController(
                                  text: snapshot.data!.email),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Email',
                                hintText: 'john.doe@nonymou.io',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    height: 3),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: TextEditingController(
                                  text: snapshot.data!.address),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Adresse',
                                hintText: '42 rue des escargots',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    height: 3),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            TextField(
                              controller: TextEditingController(
                                  text: snapshot.data!.postalCode),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Code Postal',
                                hintText: '42420',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    height: 3),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            TextField(
                              controller: TextEditingController(
                                  text: snapshot.data!.city),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Ville',
                                hintText: 'Lorette',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    height: 3),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}
