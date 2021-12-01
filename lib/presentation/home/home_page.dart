import 'package:flutter/material.dart';

import '../home/widgets/crowdaction_carousel.dart';
import '../themes/constants.dart';
import 'widgets/current_upcoming_layout.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 'IN THE SPOTLIGHT' carousel code BEGINS
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 3),
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
            child: const Text(
              'In the Spotlight',
              textAlign: TextAlign.center,
              style: TextStyle(color: kSecondaryColor, fontSize: 20),
            ),
          ),
          const CrowdActionCarousel(),
          // 'IN THE SPOTLIGHT' carousel code ENDS
          const CurrentAndUpcomingLayout(),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
            child: const Text(
              'Share CollAction with your friends carousel',
              textAlign: TextAlign.center,
              style: TextStyle(color: kSecondaryColor, fontSize: 20),
            ),
          ),
          const CurrentAndUpcomingLayout(isCurrent: false),
        ],
      ),
    );
  }
}
