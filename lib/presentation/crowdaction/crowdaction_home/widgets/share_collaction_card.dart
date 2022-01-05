import 'package:collaction_app/presentation/crowdaction/crowdaction_home/widgets/share_collaction_button.dart';
import 'package:flutter/material.dart';

import '../../../themes/constants.dart';

class ShareCollActionCard extends StatelessWidget {
  const ShareCollActionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: kShadowColor,
            blurRadius: 4.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kPrimaryColor400,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Share CollAction with\n your friends!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Join a CrowdAction together with your friends and amplify your impact",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: kSecondaryColor),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const ShareCollactionButton(),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
