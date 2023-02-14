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
        backgroundColor: context.colors.secondaryColor,
        leading: RawMaterialButton(
          elevation: 5,
          onPressed: () => context.router.pop(),
          child: CircleAvatar(
            backgroundColor: context.colors.secondaryColor,
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: context.colors.primaryColor300,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
              backgroundColor:
                  MaterialStateProperty.all(context.colors.secondaryColor),
              elevation: MaterialStateProperty.all(2),
            ),
            onPressed: () => context.router.pop(),
            child: CircleAvatar(
              backgroundColor: context.colors.secondaryColor,
              child: Icon(
                Icons.close_outlined,
                color: context.colors.primaryColor300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
