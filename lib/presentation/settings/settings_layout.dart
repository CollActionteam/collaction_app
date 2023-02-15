import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

class SettingsLayout extends StatelessWidget {
  const SettingsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.kTheme.secondaryColor,
        leading: RawMaterialButton(
          elevation: 5,
          onPressed: () => context.router.pop(),
          child: CircleAvatar(
            backgroundColor: context.kTheme.secondaryColor,
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: context.kTheme.primaryColor300,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
              backgroundColor:
                  MaterialStateProperty.all(context.kTheme.secondaryColor),
              elevation: MaterialStateProperty.all(2),
            ),
            onPressed: () => context.router.pop(),
            child: CircleAvatar(
              backgroundColor: context.kTheme.secondaryColor,
              child: Icon(
                Icons.close_outlined,
                color: context.kTheme.primaryColor300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
