import 'package:collaction_app/presentation/shared_widgets/crowdaction_card.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:collaction_app/presentation/shared_widgets/return_elevated_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/crowdaction/crowdaction.dart';
import './widgets/bottom_navbar.dart';
import '../themes/constants.dart';

class CrowdActionDetailsPage extends StatefulWidget {
  const CrowdActionDetailsPage({Key? key}) : super(key: key);

  @override
  _CrowdActionDetailsPageState createState() => _CrowdActionDetailsPageState();
}

class _CrowdActionDetailsPageState extends State<CrowdActionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: Move CrowdAction to parameter field
    final crowdAction = CrowdAction(
      name: 'Plasticdieet',
      numParticipants: 23,
      description:
          'Een maand zonder plastic wegwerpproducten en plastic verpakkingen: het klinkt onmogelijk of onaantrekkelijk, maar het Plasticdieet bewijst het tegendeel. Want wees nou eerlijk, heb je echt dat plastic flesje water of dat plastic roerstaafje voor je koffie nodig?',
      start: DateTime.now(),
      end: DateTime.now(),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: const PillButton(
        text: 'Participate',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavbar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          // TODO: Get crowdAction image
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80'),
                            ),
                          ),
                          height: 300.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              returnElevatedButton(context),
                              ElevatedButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) => kAlmostTransparent,
                                  ),
                                  elevation:
                                      MaterialStateProperty.all<double>(4.0),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    const CircleBorder(),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    kAccentColor,
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(40, 40)),
                                ),
                                onPressed: () => {} /*context.router.pop(),*/,
                                child: Image.asset(
                                    'assets/images/icons/share.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: kAlmostTransparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 22.0),
                        child: Column(
                          children: [
                            Text(
                              // Title
                              crowdAction.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 28.0,
                                color: kPrimaryColor400,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 85.0,
                                  width: 100.0,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // TODO: Avatars based on participants
                                      Positioned(
                                        left: 50,
                                        child: Container(
                                          height: 40.0,
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: const DecorationImage(
                                                image: NetworkImage(
                                                    'https://i.imgur.com/kwV7YF6.png')),
                                            border: Border.all(
                                                color: kAlmostTransparent,
                                                width: 3.0),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 25,
                                        // top: 25.0,
                                        child: Container(
                                          height: 40.0,
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: const DecorationImage(
                                                image: NetworkImage(
                                                    'https://i.imgur.com/kwV7YF6.png')),
                                            border: Border.all(
                                                color: kAlmostTransparent,
                                                width: 3.0),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        child: Container(
                                          height: 40.0,
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: const DecorationImage(
                                              image: NetworkImage(
                                                  'https://i.imgur.com/kwV7YF6.png'),
                                            ),
                                            border: Border.all(
                                              color: kAlmostTransparent,
                                              width: 3.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    // TODO: Text based on participants
                                    Text(
                                      "Join Barbara, Mike and 23 others!",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: kPrimaryColor300),
                                    ),
                                  ],
                                ),
                                Expanded(child: Row()),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 30.0,
                                  color: kSecondaryTransparent,
                                ),
                              ],
                            ),
                            Text(
                              // TODO: Crowdaction description
                              crowdAction.description,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0,
                                color: kPrimaryColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        color: kSecondaryColor,
                        child: const Text(
                          'My commitments',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: kAlmostTransparent,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'My badge',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                  ),
                                ),
                                // Hero(
                                //   tag: _heroTag,
                                //   child: IconButton(
                                //     onPressed: () {
                                //       // Navigator.of(context).push(
                                //       //   HeroDialogRoute(
                                //       //     builder: (context) {
                                //       //       return const _AddTodoPopupCard();
                                //       //     },
                                //       //   ),
                                //       // );
                                //     },
                                //     icon: Image.asset(
                                //       'assets/images/icons/tip.png',
                                //       color: kAccentColor,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Short description about what the badges are and how to achieve different levels',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kPrimaryColor300,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/gold_badge.png',
                                  height: 100,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Jan, 2021',
                                  style: TextStyle(
                                    color: kPrimaryColor300,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Title of the crowdaction',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Gold',
                                  style: TextStyle(
                                    color: kPrimaryColor300,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'This CrowdAction was created by',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/user.png',
                                height: 52,
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                'Barbara',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _BadgesModal extends StatelessWidget {
//   const _BadgesModal({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Hero(
//           tag: _heroTag,
//           child: Row(
//             children: const [
//               Text('Hello!'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
