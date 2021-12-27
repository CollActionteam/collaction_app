import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../presentation/contact_form/widgets/contact_form.dart';
import '../../presentation/crowd_action/pages/widgets/share_collaction_card.dart';
import '../../presentation/shared_widgets/content_placeholder.dart';
import '../../presentation/themes/constants.dart';
// import '../../presentation/shared_widgets/custom_fab.dart';

class CaptivePage extends StatelessWidget {
  const CaptivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAlmostTransparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: kAlmostTransparent,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      // Leaving this commented for now, not sure what it should do ...
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     CustomFAB(
                      //       isMini: true,
                      //       onPressed: () {},
                      //       child: const Icon(Icons.settings),
                      //     )
                      //   ],
                      // ),
                      ContentPlaceholder(
                        textColor: kPrimaryColor400,
                        description:
                            "The first testing round and CrowdActions have come to their end! Stay tuned for the next release.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: const [
                  SizedBox(height: 40),
                  Text(
                    'Veganuary CrowdAction | ASML',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: kPrimaryColor400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'ASML used Collaction to host their company-wide Veganuary challenge.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      color: kPrimaryColor400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Is this an implemented feature?
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text("Show my impact"),
                  // ),
                  SizedBox(height: 40),
                  ShareCollActionCard(),
                  ContactForm(
                    edgeInsets:
                        EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              left: false,
              right: false,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                color: kAlmostTransparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      onPressed: () => launch('https://collaction.org'),
                      mini: true,
                      child: SvgPicture.asset(
                        'assets/vectors/globe.svg',
                        color: kInactiveColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      onPressed: () =>
                          launch('https://instagram.com/collaction_org'),
                      mini: true,
                      child: SvgPicture.asset(
                        'assets/vectors/insta.svg',
                        color: kInactiveColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      onPressed: () => launch(
                          'https://linkedin.com/company/15079855/admin/'),
                      mini: true,
                      child: SvgPicture.asset(
                        'assets/vectors/linkedin.svg',
                        color: kInactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}