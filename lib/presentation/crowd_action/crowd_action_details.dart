import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../shared_widgets/custom_app_bars/clean_app_bar.dart';
import '../shared_widgets/rectangle_button.dart';
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
      description:
          'Een maand zonder plastic wegwerpproducten en plastic verpakkingen: het klinkt onmogelijk of onaantrekkelijk, maar het Plasticdieet bewijst het tegendeel. Want wees nou eerlijk, heb je echt dat plastic flesje water of dat plastic roerstaafje voor je koffie nodig?',
      start: DateTime.now(),
      end: DateTime.now(),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CleanAppBar(title: crowdAction.name),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // CrowdAction image
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://collaction-production.s3.eu-central-1.amazonaws.com/33d8a1b0-7668-4d61-9c06-ec6c64f01028.png'),
                      ),
                    ),
                    height: 300.0,
                  ),
                  Material(
                    // Participants Widget
                    child: InkWell(
                      overlayColor:
                          MaterialStateProperty.all<Color?>(kAlmostTransparent),
                      onTap:
                          () {}, // TODO: Go to participants of this crowdaction
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 22.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 85.0,
                              width: 110.0,
                              child: Stack(
                                children: [
                                  // TODO: Avatars based on participants
                                  Positioned(
                                    left: 45,
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
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
                                      height: 60.0,
                                      width: 60.0,
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
                                    left: 22.5,
                                    top: 25.0,
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
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
                                ],
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                // TODO: Text based on participants
                                Text(
                                  "Join Barbara, Mike and 23 others!",
                                  style: TextStyle(
                                      fontSize: 14.0, color: kPrimaryColor300),
                                ),
                                Text(
                                  "See who else is participating",
                                  style: TextStyle(
                                      fontSize: 14.0, color: kPrimaryColor200),
                                ),
                              ],
                            ),
                            Expanded(child: Row()),
                            const Icon(Icons.arrow_forward_ios,
                                size: 30.0, color: kSecondaryTransparent)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.0),
                        child: Text(
                          "Goals",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28.0,
                            color: kPrimaryColor400,
                          ),
                        ),
                      ),
                      Row(
                        // List of Goals with Checkbox
                        children: [
                          Expanded(
                            // Goal item Widget
                            child: CheckboxListTile(
                              value: true,
                              onChanged: (_) {}, // TODO: Implement onChanged,
                              activeColor: kAccentColor,
                              title: Row(
                                children: const [
                                  Text(
                                    "1.", // TODO: Change based on goal 'number' (index in list)
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 26.0),
                                  ),
                                  SizedBox(width: 6.0),
                                  Text(
                                    "I will not buy any plastic in January", // TODO: Change based on goal 'short description'
                                    style: TextStyle(
                                        color: kPrimaryColor, fontSize: 16.0),
                                  ),
                                ],
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            const SizedBox(height: 10.0),
                            Text(
                              // Description
                              crowdAction.description,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0,
                                color: kPrimaryColor,
                                height: 1.4,
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  // Find out more button
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets?>(
                                            EdgeInsets.zero),
                                  ),
                                  onPressed: () => launch(
                                      'https://www.collaction.org/crowdactions/plasticdieet/3'),
                                  child: const Text(
                                    "Click here to find out more!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "Discussion",
                              style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor400),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Material(
                        child: InkWell(
                          overlayColor: MaterialStateProperty.all<Color?>(
                              kAlmostTransparent),
                          onTap:
                              () {}, // TODO: Go to discussion of this crowdaction
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Row(
                              children: [
                                const Icon(Icons.question_answer_outlined,
                                    size: 75.0, color: kSecondaryTransparent),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    // TODO: Text based on discussion
                                    Text(
                                      "There are currently no discussion",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: kPrimaryColor300),
                                    ),
                                    Text(
                                      "Be the first to start one",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: kPrimaryColor200),
                                    ),
                                  ],
                                ),
                                Expanded(child: Row()),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 30.0, color: kSecondaryTransparent)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Row(
            children: const [
              Expanded(
                child: RectangleButton(
                  text: 'Verify goals to participate',
                  enabled: false,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
