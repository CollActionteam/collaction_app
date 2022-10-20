import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../themes/constants.dart';

class SettingsLayout extends StatelessWidget {
  const SettingsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondaryColor,
        leading: RawMaterialButton(
          elevation: 5,
          onPressed: () => context.router.pop(),
          child: const CircleAvatar(
            backgroundColor: kSecondaryColor,
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: kPrimaryColor300,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
              backgroundColor: MaterialStateProperty.all(kSecondaryColor),
              elevation: MaterialStateProperty.all(2),
            ),
            onPressed: () => context.router.pop(),
            child: const CircleAvatar(
              backgroundColor: kSecondaryColor,
              child: Icon(
                Icons.close_outlined,
                color: kPrimaryColor300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
