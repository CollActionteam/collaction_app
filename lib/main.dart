import 'package:collaction_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to CollAction',
        theme: ThemeData(
          primaryColor: Color(0xff23d884),
        ),
        home: HomeScreen());
  }
}
