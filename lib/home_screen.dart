import 'package:flutter/material.dart';

import 'crowd_action_browse_route.dart';
import 'utilities.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to CollAction'),
        backgroundColor: Color(0xff23d884),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello user!'),
            ElevatedButton(
              onPressed: () {
                Utilities.launchScreen(context, CrowdActionBrowseRoute());
              },
              child: Text('Browse actions'),
            ),
          ],
        ),
      ),
    );
  }
}
