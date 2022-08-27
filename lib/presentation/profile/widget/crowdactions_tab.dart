import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/profile/widget/signup_cta.dart';
import 'package:collaction_app/presentation/shared_widgets/micro_crowdaction_card.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';

class CrowdActionsTab extends StatelessWidget {
  final User? user;
  final List<CrowdAction>? crowdActions;

  const CrowdActionsTab({
    Key? key,
    this.user,
    this.crowdActions,
  }) : super(key: key);

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
                    MicroCrowdActionCard(
                      c,
                      viewOnly: true,
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ],
            if (user == null) ...[
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
