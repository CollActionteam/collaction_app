import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../routes/app_routes.gr.dart';
import '../../themes/constants.dart';

class CurrentAndUpcomingLayout extends StatelessWidget {
  final bool isCurrent;

  // the below crowdAction list is the first 3 that will be shown onthe homescreen
  // and hence need to be passed from home_page
  final List<Map<String, dynamic>> crowdActionsList;
  const CurrentAndUpcomingLayout({
    Key? key,
    this.isCurrent = true,
    this.crowdActionsList = const [
      {
        'id': 'CA_ID', // CrowdAction Id in Database for signing up the user
        'headline': 'This is the headline for the crowdaction',
        'description': 'Here comes the description of the shown crowdaction',
        'crowdaction_img': 'assets/images/ocean.png',
      },
      {
        'id': 'CA_ID', // CrowdAction Id in Database for signing up the user
        'headline': 'This is the headline for the crowdaction',
        'description': 'Here comes the description of the shown crowdaction',
        'crowdaction_img': 'assets/images/ocean.png',
      },
      {
        'id': 'CA_ID', // CrowdAction Id in Database for signing up the user
        'headline': 'This is the headline for the crowdaction',
        'description': 'Here comes the description of the shown crowdaction',
        'crowdaction_img': 'assets/images/ocean.png',
      }
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isCurrent ? 'Currently running' : 'Upcoming',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 28.0),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.router.push(const CrowdActionBrowseRoute()),
                    child: const Text(
                      'View all',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                          color: kAccentColor),
                    ),
                  ),
                  // const SizedBox(height: 3),
                ],
              ),
            ),
            ...crowdActionsList.map(
              (e) => Container(
                height: 148,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image:
                                    AssetImage(e['crowdaction_img'].toString()),
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.only(left: 10),
                        height: 128,
                        width: 100,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabelForCrowdAction().customLabelBox(
                                const Icon(
                                  Icons.check,
                                  size: 20,
                                  color: kSecondaryColor,
                                ),
                                const Text(
                                  'Sign up now',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: kSecondaryColor,
                                  ),
                                ),
                                kAccentColor)!,
                            // Container(
                            //     padding: const EdgeInsets.only(
                            //         top: 10, left: 10, right: 10),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(16)),
                            //     child: const Text('Sign up now')),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Text(
                                e['headline'].toString(),
                                softWrap: false,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 6, bottom: 10),
                              child: Text(
                                e['description'].toString(),
                                softWrap: false,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: kInactiveColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20)
          ]),
    );
  }
}

class CustomLabelForCrowdAction {
  Widget? customLabelBox(Icon icon, Text txt, Color bg) {
    return Container(
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
      height: 35,
      width: 120,
      margin: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 2),
              child: icon),
          Container(
              margin: const EdgeInsets.only(top: 4, right: 4, bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
              child: txt),
        ],
      ),
    );
  }
}
