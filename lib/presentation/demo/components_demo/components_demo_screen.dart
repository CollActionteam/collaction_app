import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../shared_widgets/accent_chip.dart';
import '../../shared_widgets/crowdaction_card.dart';
import '../../shared_widgets/custom_app_bars/clean_app_bar.dart';
import '../../shared_widgets/custom_fab.dart';
import '../../shared_widgets/pill_button.dart';
import '../../shared_widgets/rectangle_button.dart';
import '../../shared_widgets/secondary_chip.dart';
import '../../crowdaction/crowdaction_comments/widgets/comment_delete_button.dart';
import '../../crowdaction/crowdaction_comments/widgets/comment_like_button.dart';
import '../../crowdaction/crowdaction_comments/widgets/comment_flag_button.dart';
import '../../crowdaction/crowdaction_comments/widgets/flag_comment.dart';
import '../../themes/constants.dart';

class ComponentsDemoPage extends StatefulWidget {
  const ComponentsDemoPage({super.key});

  @override
  ComponentsDemoPageState createState() => ComponentsDemoPageState();
}

class ComponentsDemoPageState extends State<ComponentsDemoPage> {
  bool likedByMe = false;
  void likeCallback() {
    setState(() {
      likedByMe = !likedByMe;
    });
  }

  bool flagged = false;
  void flagCallback(List<bool>? flags) {
    setState(() {
      flagged = true;
      debugPrint(flags?.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CleanAppBar(title: "UI Components Demo"),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              CrowdActionCard(
                crowdAction: CrowdAction(
                  id: "",
                  title:
                      "This is the headline for a crowdaction with three lines",
                  images: const Images(
                    card: "",
                    banner: "",
                  ),
                  category: "Sustainability",
                  subcategory: "Community",
                  commitments: [
                    Commitment(
                      id: "",
                      label: "no-beef",
                      description: "Don't eat beef for 30 days!",
                      points: 0,
                      blocks: [],
                    ),
                    Commitment(
                      id: "",
                      label: "vegetarian",
                      description: "Don't eat meat for 30 days!",
                      points: 0,
                      blocks: [],
                    ),
                  ],
                  endAt: DateTime.now(),
                  description: '',
                  location: const Location(
                    code: 'NL',
                    name: 'The Netherlands',
                  ),
                  status: Status.started,
                  joinStatus: JoinStatus.open,
                  participantCount: 0,
                ),
              ),
              const SizedBox(height: 24.0),
              CrowdActionCard(
                crowdAction: CrowdAction(
                  id: "",
                  title:
                      "This is the headline for a crowdaction with three lines",
                  images: const Images(
                    card: "",
                    banner: "",
                  ),
                  category: "Sustainability",
                  subcategory: "Community",
                  commitments: [
                    Commitment(
                      id: "",
                      label: "no-beef",
                      description: "Don't eat beef for 30 days!",
                      points: 0,
                      blocks: [],
                    ),
                    Commitment(
                      id: "",
                      label: "vegetarian",
                      description: "Don't eat meat for 30 days!",
                      points: 0,
                      blocks: [],
                    ),
                  ],
                  endAt: DateTime.now(),
                  description: '',
                  location: const Location(
                    code: 'NL',
                    name: 'The Netherlands',
                  ),
                  status: Status.started,
                  joinStatus: JoinStatus.open,
                  participantCount: 0,
                ),
              ),
              const SizedBox(height: 24.0),
              RectangleButton(
                text: "Next",
                onTap: () {},
              ),
              RectangleButton(
                text: "Next",
                onTap: () {},
                enabled: false,
              ),
              RectangleButton(
                leading: const Icon(Icons.upload_rounded, color: Colors.white),
                text: "Upload Profile Picture",
                onTap: () {},
              ),
              RectangleButton(
                leading: const Icon(Icons.upload_rounded, color: Colors.white),
                text: "Upload Profile Picture",
                onTap: () {},
                enabled: false,
              ),
              PillButton(
                text: "Next",
                onTap: () {},
              ),
              PillButton(
                text: "Next",
                onTap: () {},
                isEnabled: false,
              ),
              PillButton.icon(
                leading: const Icon(Icons.upload_rounded),
                text: "Upload Profile Picture",
                onTap: () {},
              ),
              PillButton.icon(
                leading: const Icon(Icons.upload_rounded),
                text: "Upload Profile Picture",
                onTap: () {},
                isEnabled: false,
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Skip for now"),
              ),
              const TextButton(
                onPressed: null,
                child: Text("Skip for now"),
              ),
              Wrap(
                spacing: 12.0,
                children: [
                  const AccentChip(
                    text: "Coming Soon",
                  ),
                  const AccentChip(
                    text: "Coming Soon",
                    leading: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  AccentChip(
                    text: "Coming Soon",
                    onDeleted: () {},
                  ),
                  AccentChip(
                    text: "Coming Soon",
                    leading: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    onDeleted: () {},
                  ),
                ],
              ),
              Wrap(
                spacing: 12.0,
                children: [
                  const SecondaryChip(
                    text: "Sustainability",
                  ),
                  const SecondaryChip(
                    text: "Sustainability",
                    leading: Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                  ),
                  SecondaryChip(
                    text: "Sustainability",
                    onDeleted: () {},
                  ),
                  SecondaryChip(
                    text: "Sustainability",
                    leading: const Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    onDeleted: () {},
                  ),
                ],
              ),
              Wrap(
                spacing: 12.0,
                children: [
                  CustomFAB(
                    onPressed: () {},
                    isMini: true,
                    child: const Icon(Icons.add),
                  ),
                  CustomFAB(
                    onPressed: () {},
                    heroTag: 'fab2',
                    child: const Icon(Icons.add),
                  ),
                  const CustomFAB(
                    isMini: true,
                    heroTag: 'fab3',
                    child: Icon(Icons.add),
                  ),
                  const CustomFAB(
                    heroTag: 'fab4',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              /// TEMP: delete once #304 is approved
              Wrap(
                spacing: 12.0,
                children: [
                  CommentLikeButton(
                    likedByMe: likedByMe,
                    onTap: likeCallback,
                  ),
                  CommentFlagButton(
                    flagged: flagged,
                    onTap: () => {
                      if (!flagged) _flagModal(context) else flagged = !flagged
                    },
                  ),
                  CommentDeleteButton(
                    onTap: () => _deleteModal(context),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  /// TEMP: move modals to CrowdActionCommentPage once #304 is approved
  void _deleteModal(BuildContext context) {
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Container(
                  width: 60.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kSecondaryTransparent,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Delete comment",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                PillButton(
                  text: "Delete my comment",
                  onTap: () => {},
                  margin: EdgeInsets.zero,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        });
  }

  void _flagModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return FlagComment(
          flagged: false,
        );
      },
    );
  }
}
