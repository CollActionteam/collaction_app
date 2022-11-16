import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/user/user.dart';
import '../../shared_widgets/micro_crowdaction_card.dart';
import '../../themes/constants.dart';
import 'signup_cta.dart';

class CrowdActionsTab extends StatelessWidget {
  final User? user;
  final List<CrowdAction>? crowdActions;

  const CrowdActionsTab({
    super.key,
    this.user,
    this.crowdActions,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (crowdActions?.isEmpty ?? false) ...[
              const SizedBox(height: 40),
              Image.asset('assets/images/crowdactions_tab_empty.png'),
              const SizedBox(height: 40),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10) +
                    const EdgeInsets.only(top: 20),
                child: const Text(
                  'My crowdactions',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28.0,
                    color: kPrimaryColor400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...crowdActions!.map(
                (c) => Column(
                  children: [
                    MicroCrowdActionCard(c),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
            if (user == null || (crowdActions?.isEmpty ?? false)) ...[
              SignUpCTA(
                user: user,
                title: 'All CrowdActions you have participated in',
              ),
            ]
          ],
        ),
      ),
    );
  }
}
