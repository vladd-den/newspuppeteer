import 'package:flutter/material.dart';
import 'package:projectest/screen/home_page.dart';
import 'package:projectest/screen/login_screen.dart';


void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqflite App',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}