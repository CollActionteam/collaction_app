import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../home/widgets/crowdaction_carousel.dart';
import '../routes/app_routes.gr.dart';
import '../themes/constants.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upcoming crowdactions',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.0),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.router.push(const CrowdActionBrowseRoute()),
                      child: const Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: kIrisColor),
                      ),
                    ),
                  ],
                ),
                const CrowdActionCarousel(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
