import 'package:flutter/material.dart';

import 'crowd_action_browse_route.dart';
import 'contact_form.dart';
import 'utilities.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to CollAction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Hello user!'),
            ElevatedButton(
              onPressed: () {
                Utilities.launchRoute(context, CrowdActionBrowseRoute());
              },
              child: Text('Browse actions'),
            ),
            ElevatedButton(
                onPressed: () {
                  Utilities.launchRoute(context, ContactForm());
                },
                child: Text('Give feedback or start crowd action'))
          ],
        ),
      ),
    );
  }
}
