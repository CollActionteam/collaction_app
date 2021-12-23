import 'package:flutter/material.dart';

class DemoTabPage extends StatefulWidget {
  const DemoTabPage({Key? key}) : super(key: key);

  @override
  _DemoTabPageState createState() => _DemoTabPageState();
}

class _DemoTabPageState extends State<DemoTabPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is a different page on another index!!'),
    );
  }
}
