import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:restapis/Models/user_model.dart';
//Import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  
  List<UserModel> userList = [];

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
    );
  }
}
