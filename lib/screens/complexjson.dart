import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:restapis/Models/user_model.dart';
import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<UserModel> userList = [];
  bool isDecending = false;

  Future<List<UserModel>> getUser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(Map<String, dynamic>.from(i)));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Play  with  APIs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: FutureBuilder(
          future: getUser(),
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReusableRow(
                              title: 'UserName: ',
                              value: snapshot.data![index].username.toString(),
                            ),
                            ReusableRow(
                              title: 'Name: ',
                              value: snapshot.data![index].name.toString(),
                            ),
                            ReusableRow(
                              title: 'Email: ',
                              value: snapshot.data![index].email.toString(),
                            ),
                            ReusableRow(
                              title: 'Address: ',
                              value: snapshot.data![index].address!.city
                                  .toString(),
                            ),
                            ReusableRow(
                              title: 'Latitude: ',
                              value: snapshot.data![index].address!.geo!.lat
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
