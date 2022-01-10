// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// import '../../../presentation/shared_widgets/custom_fab.dart';
import '../../../presentation/utils/launch_url.dart';
import '../../presentation/contact_form/widgets/contact_form.dart';
import '../../presentation/shared_widgets/content_placeholder.dart';
import '../../presentation/themes/constants.dart';
import '../core/collaction_icons.dart';
import '../crowdaction/crowdaction_home/widgets/share_collaction_card.dart';
// import '../routes/app_routes.gr.dart';

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
                        /*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomFAB(
                              isMini: true,
                              onPressed: () =>
                                  context.router.push(const SettingsRoute()),
                              child: const Icon(Icons.settings),
                            )
                          ],
                        ),
                        */
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
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () =>
                          launchUrl("https://www.collaction.org/impact"),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Show my impact ",
                              style: TextStyle(
                                color: kEnabledButtonColor,
                              ),
                            ),
                            WidgetSpan(
                              child: Icon(
                                CollactionIcons.external_link,
                                size: 14,
                                color: kEnabledButtonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        onPressed: () => launchUrl('https://collaction.org'),
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
                            launchUrl('https://instagram.com/collaction_org'),
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
                        onPressed: () => launchUrl(
                          'https://linkedin.com/company/15079855/',
                        ),
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
