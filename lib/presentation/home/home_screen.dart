import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 23.0, horizontal: 23.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming crowdactions',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.0),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.router.push(CrowdActionBrowseRoute()),
                      child: Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: kIrisColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
