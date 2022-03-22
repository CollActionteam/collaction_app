// TODO Untested! (Confirm if it works as intended)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../.../../../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../presentation/shared_widgets/content_placeholder.dart';
import '../../../../presentation/themes/constants.dart';

class ParticipationCountText extends StatelessWidget {
  const ParticipationCountText({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  final CrowdAction crowdAction;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotlightBloc, SpotlightState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: () {
            final count = crowdAction.participantCount;
            return Text(
              "Join $count participant${count <= 1 ? "" : "s"}",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: 14,
                    color: kPrimaryColor300,
                    height: 1.2,
                  ),
            );
          },
          fetchingCrowdSpotLightActions: () {
            return const Center(
              child: CircularProgressIndicator(
                color: kAccentColor,
              ),
            );
          },
          spotLightCrowdActionsError: (_) {
            return const ContentPlaceholder(
              textColor: Colors.white,
            );
          },
          spotLightCrowdActions: (_crowdActions) {
            final CrowdAction _updatedCrowdAction = _crowdActions.firstWhere(
              (element) => element.crowdactionID == crowdAction.crowdactionID,
            );
            final count = _updatedCrowdAction.participantCount;
            return Text("Join $count participant${count <= 1 ? "" : "s"}");
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }
}
