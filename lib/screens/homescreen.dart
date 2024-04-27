import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapis/utilities/model_p.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> posts = [];
  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        posts.add(PostsModel.fromJson(Map<String, dynamic>.from(i)));
      }
      return posts;
    } else {
      return posts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Play  with  APIs',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          backgroundColor: Colors.green.shade900),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              } else {
                return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(posts[index].title.toString()),
                              Text(posts[index].body.toString()),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
