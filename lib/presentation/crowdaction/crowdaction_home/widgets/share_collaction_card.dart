import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'share_collaction_button.dart';

class ShareCollActionCard extends StatelessWidget {
  const ShareCollActionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: context.kTheme.shadowColor!,
            blurRadius: 4.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: context.kTheme.primaryColor400,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Share CollAction with\n your friends!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.kTheme.secondaryColor,
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
                    .bodySmall
                    ?.copyWith(color: context.kTheme.secondaryColor),
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
