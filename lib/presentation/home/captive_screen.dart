import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_home/widgets/share_collaction_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../presentation/contact_form/widgets/contact_form.dart';
import '../../presentation/shared_widgets/content_placeholder.dart';
import '../../presentation/themes/constants.dart';
// TODO import '../../presentation/shared_widgets/custom_fab.dart';

class CaptivePage extends StatelessWidget {
  const CaptivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Make screen captive
      child: Scaffold(
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
                        // TODO: Leaving this commented for now, not sure what it should do ...
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
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Veganuary CrowdAction | ASML',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ASML used Collaction to host their company-wide Veganuary challenge.',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: kPrimaryColor400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () =>
                          launch("https://www.collaction.org/impact"),
                      child: const Text("Show my impact"),
                    ),
                    const SizedBox(height: 40),
                    const ShareCollActionCard(),
                    const ContactForm(
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
                        child: const Icon(
                          CollactionIcons.globe,
                          color: kPrimaryColor400,
                        ),
                      ),
                      const SizedBox(width: 5),
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        onPressed: () =>
                            launch('https://instagram.com/collaction_org'),
                        mini: true,
                        child: const Icon(
                          CollactionIcons.instagram,
                          color: kPrimaryColor400,
                        ),
                      ),
                      const SizedBox(width: 5),
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        onPressed: () => launch(
                            'https://linkedin.com/company/15079855/admin/'),
                        mini: true,
                        child: const Icon(
                          CollactionIcons.linkedin,
                          color: kPrimaryColor400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
