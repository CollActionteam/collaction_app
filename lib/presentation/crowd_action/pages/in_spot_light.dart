import 'package:collaction_app/presentation/crowd_action/pages/widgets/bottom_navbar.dart';
import 'package:collaction_app/presentation/crowd_action/pages/widgets/share_collaction_card.dart';
import 'package:flutter/material.dart';

import 'widgets/in_spotlight_header.dart';

class InSpotLightPage extends StatelessWidget {
  const InSpotLightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: const [
            InSpotLightHeader(),
            ShareCollActionCard(),
          ],
        ),
      ),
    );
  }
}
