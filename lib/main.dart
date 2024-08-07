import 'package:flutter/material.dart';
import 'package:restapis/screens/complexjson.dart';
import 'package:restapis/screens/signupscreen.dart';
import 'package:restapis/screens/homescreen.dart';
import 'dart:ui';

import 'package:restapis/screens/example2.dart';
import 'package:restapis/screens/uploadimage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const UploadImageScreen());
  }
}
