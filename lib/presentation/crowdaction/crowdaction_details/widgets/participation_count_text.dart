// TODO Untested! (Confirm if it works as intended)

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../.../../../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../presentation/shared_widgets/content_placeholder.dart';
import '../../../../presentation/themes/constants.dart';
import '../../../routes/app_routes.gr.dart';

class ParticipationCountText extends StatelessWidget {
  const ParticipationCountText({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  final CrowdAction crowdAction;

  Widget participantText(BuildContext context, int count) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          CrowdActionParticipantsRoute(
            crowdactionId: crowdAction.id,
          ),
        );
      },
      child: Text(
        "Join $count participant${count == 1 ? "" : "s"}",
        style: Theme.of(context).textTheme.caption?.copyWith(
              fontSize: 14,
              color: kPrimaryColor300,
              height: 1.2,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotlightBloc, SpotlightState>(
      builder: (context, state) {
        return state.maybeWhen(
          initial: () {
            final count = crowdAction.participantCount;
            return participantText(context, count);
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
              (element) => element.id == crowdAction.id,
            );
            final count = _updatedCrowdAction.participantCount;
            return participantText(context, count);
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }
}
