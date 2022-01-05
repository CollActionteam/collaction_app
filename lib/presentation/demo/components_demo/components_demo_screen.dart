import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../core/collaction_icons.dart';
import '../../shared_widgets/accent_action_chip.dart';
import '../../shared_widgets/accent_chip.dart';
import '../../shared_widgets/crowdaction_card.dart';
import '../../shared_widgets/custom_app_bars/clean_app_bar.dart';
import '../../shared_widgets/custom_fab.dart';
import '../../shared_widgets/pill_button.dart';
import '../../shared_widgets/rectangle_button.dart';
import '../../shared_widgets/secondary_chip.dart';

class ComponentsDemoPage extends StatefulWidget {
  const ComponentsDemoPage({Key? key}) : super(key: key);

  @override
  _ComponentsDemoPageState createState() => _ComponentsDemoPageState();
}

class _ComponentsDemoPageState extends State<ComponentsDemoPage> {
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
                  crowdactionID: "",
                  title:
                      "This is the headline for a crowdaction with three lines",
                  images: const Images(
                    card:
                        "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
                    banner:
                        "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
                  ),
                  category: "Sustainability",
                  subCategory: "Community",
                  commitmentOptions: [
                    CommitmentOption(
                      id: "",
                      label: "no-beef",
                      description: "Don't eat beef for 30 days!",
                    ),
                    CommitmentOption(
                      id: "",
                      label: "vegetarian",
                      description: "Don't eat meat for 30 days!",
                    ),
                  ],
                  dateEnd: DateTime.now(),
                  dateLimitJoin: DateTime.now(),
                  dateStart: DateTime.now(),
                  description: '',
                  location: '',
                  participantCount: 0,
                  topParticipants: [],
                ),
              ),
              const SizedBox(height: 24.0),
              CrowdActionCard(
                crowdAction: CrowdAction(
                  crowdactionID: "",
                  title:
                      "This is the headline for a crowdaction with three lines",
                  images: const Images(
                    card:
                        "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
                    banner:
                        "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
                  ),
                  category: "Sustainability",
                  subCategory: "Community",
                  commitmentOptions: [
                    CommitmentOption(
                      id: "",
                      label: "no-beef",
                      description: "Don't eat beef for 30 days!",
                    ),
                    CommitmentOption(
                      id: "",
                      label: "vegetarian",
                      description: "Don't eat meat for 30 days!",
                    ),
                  ],
                  dateEnd: DateTime.now(),
                  dateLimitJoin: DateTime.now(),
                  dateStart: DateTime.now(),
                  description: '',
                  location: '',
                  participantCount: 0,
                  topParticipants: [],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AccentActionChip(
                    () {},
                    text: 'Sign up now',
                    leading: const Icon(
                      CollactionIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  AccentActionChip(() {}, text: 'Click me!'),
                  const SizedBox(width: 10.0),
                  AccentActionChip(() {}, text: 'I have material'),
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
