import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/crowdaction/commitment.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/participant.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/commitment_card.dart';
import '../../shared_widgets/participant_avatars.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';
import '../utils/crowd_action.ext.dart';

class CrowdActionDetailsPage extends StatelessWidget {
  final CrowdAction crowdAction;

  const CrowdActionDetailsPage({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Todo remove this dummy data once pull request is approved
    final List<Commitment> commitments = [];
    for (int i = 0; i < 10; i++) {
      commitments.add(Commitment(
        id: i,
        title: 'Commitment $i',
        description: 'Some description here hi',
      ));
    }
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 310.0,
              pinned: true,
              backgroundColor: kAccentColor,
              automaticallyImplyLeading: false,
              title: Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => context.router.pop(),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: Colors.white,
                      onPrimary: kAccentColor,
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: kPrimaryColor200,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  /* TODO implement crowdaction sharing
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: kAccentColor,
                      onPrimary: kAccentColor,
                    ),
                    child: const Icon(CupertinoIcons.share, color: Colors.white),
                  )
                  */
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  crowdAction.image ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: kAlmostTransparent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crowdAction.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      spacing: 12.0,
                      children: crowdAction.toChips(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.router
                            .push(const CrowdActionParticipantsRoute());
                      },
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            // TODO - Add participants to crowdaction
                            SizedBox(
                              width: 100,
                              child: ParticipantAvatars(
                                participants: sampleParticipants,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Text(
                              "Join ${sampleParticipants.title(crowdAction.numParticipants)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 12),
                            ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      crowdAction.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 17, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              CommitmentCardList.builder(
                commitments: commitments,
                onSelected: (int selectedId) {
                  /* TODO do something with the selected commitment id
                  you'll probably want to add it to an array in a bloc */
                },
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "This CrowdAction was created by",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(
                              "https://source.unsplash.com/mEZ3PoFGs_k/500x500"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Barbra",
                          style: TextStyle(
                            fontSize: 17,
                            color: kPrimaryColor400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    PillButton(
                      text: "Participate",
                      margin: EdgeInsets.zero,
                      onTap: () => _participate(context),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _participate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 60.0,
                  height: 3.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kSecondaryTransparent,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Modal title",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Modal description. Nam quis nulla. Integer malesuada. In in enim a arcu imperdiet malesuada. Sed vel lectus. Donec odio urna, tempus molestie, porttitor ut, iaculis quis.",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: kPrimaryColor400,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PillButton(
                  text: "Confirm Participation",
                  onTap: () {},
                  margin: EdgeInsets.zero,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                )
              ],
            ),
          );
        });
  }
}


