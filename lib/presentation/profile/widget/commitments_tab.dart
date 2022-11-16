import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/user/user.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/commitments/commitment_card.dart';
import '../../themes/constants.dart';
import 'signup_cta.dart';

class CommitmentsTab extends StatelessWidget {
  final User? user;
  final List<CrowdAction>? crowdActions;

  const CommitmentsTab({
    super.key,
    this.user,
    this.crowdActions,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            if (crowdActions?.isEmpty ?? false) ...[
              const SizedBox(height: 40),
              Image.asset('assets/images/commitments_tab_empty.png'),
              const SizedBox(height: 40),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10) +
                    const EdgeInsets.only(top: 20),
                child: const Text(
                  'My commitments',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28.0,
                    color: kPrimaryColor400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...crowdActions!
                  .where((crowdAction) => crowdAction.isRunning)
                  .map(
                    (crowdAction) => GestureDetector(
                      onTap: () => context.router.push(
                        CrowdActionDetailsRoute(crowdAction: crowdAction),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            crowdAction.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ...crowdAction.commitmentOptions.map(
                            (co) => CommitmentCard(
                              commitment: co,
                              viewOnly: true,
                            ),
                          ),
                          const SizedBox(height: 15)
                        ],
                      ),
                    ),
                  ),
            ],
            if (user == null || (crowdActions?.isEmpty ?? false)) ...[
              SignUpCTA(
                user: user,
                title: 'View your amazing commitments here',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
