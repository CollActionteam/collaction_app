import 'package:collaction_app/presentation/shared_widgets/accent_action_chip.dart';
import 'package:collaction_app/presentation/shared_widgets/crowdaction_card.dart';
import 'package:collaction_app/presentation/shared_widgets/custom_fab.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/accent_chip.dart';
import '../shared_widgets/custom_appbar.dart';
import '../shared_widgets/pill_button.dart';
import '../shared_widgets/rectangle_button.dart';
import '../shared_widgets/secondary_chip.dart';

class ComponentsDemoPage extends StatefulWidget {
  const ComponentsDemoPage({Key? key}) : super(key: key);

  @override
  _ComponentsDemoPageState createState() => _ComponentsDemoPageState();
}

class _ComponentsDemoPageState extends State<ComponentsDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: "UI Components Demo"),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const CrowdActionCard(
                title:
                    "This is the headline for a crowdaction with three lines",
                imagePath:
                    "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
                chips: [
                  AccentChip(
                    text: "Sign up now",
                    leading: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  SecondaryChip(text: "Sustainability"),
                  SecondaryChip(text: "Community"),
                ],
              ),
              const SizedBox(height: 24.0),
              const CrowdActionCard(
                title:
                    "This is the headline for a crowdaction with three lines and some do ipsum incididunt deserunt quis commodo incididunt.",
                description:
                    "This is the description for a crowdaction. It gives users an idea about the crowdaction. Dolore et consectetur culpa amet veniam non fugiat adipisicing.",
                imagePath:
                    "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
                chips: [
                  AccentChip(
                    text: "Sign up now",
                    leading: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  SecondaryChip(text: "Sustainability"),
                  SecondaryChip(text: "Community"),
                ],
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
              PillButton(
                leading: const Icon(Icons.upload_rounded, color: Colors.white),
                text: "Upload Profile Picture",
                onTap: () {},
              ),
              PillButton(
                leading: const Icon(Icons.upload_rounded, color: Colors.white),
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
                    leading: const Image(
                        image: AssetImage('assets/images/icons/add_icon.png')),
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
                    child: const Icon(Icons.add),
                  ),
                  const CustomFAB(
                    isMini: true,
                    child: Icon(Icons.add),
                  ),
                  const CustomFAB(
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
