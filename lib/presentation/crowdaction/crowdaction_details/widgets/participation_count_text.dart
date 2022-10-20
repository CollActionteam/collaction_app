import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:collaction_app/presentation/shared_widgets/shimmers/title_shimmer_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../presentation/themes/constants.dart';

class ParticipationCountText extends StatelessWidget {
  const ParticipationCountText({
    super.key,
    required this.crowdAction,
  });

  final CrowdAction? crowdAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(
        CrowdActionParticipantsRoute(
          crowdActionId: crowdAction!.id,
        ),
      ),
      child: BlocProvider<CrowdActionDetailsBloc>.value(
        value: BlocProvider.of<CrowdActionDetailsBloc>(context),
        child: BlocBuilder<CrowdActionDetailsBloc, CrowdActionDetailsState>(
          builder: (context, state) {
            return state.when(
              initial: () {
                if (crowdAction != null) {
                  return participantCountText(
                    context,
                    crowdAction!.participantCount,
                  );
                }

                return shimmer(context);
              },
              loadInProgress: () {
                if (crowdAction == null) {
                  return shimmer(context);
                }

                return participantCountText(
                  context,
                  crowdAction!.participantCount,
                );
              },
              loadSuccess: (crowdAction) {
                return participantCountText(
                  context,
                  crowdAction.participantCount,
                );
              },
              loadFailure: (_) => shimmer(context),
            );
          },
        ),
      ),
    );
  }

  Shimmer shimmer(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.black.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.2),
        child: TitleShimmerLine(
          width: MediaQuery.of(context).size.width * 0.4,
        ),
      );

  Text participantCountText(BuildContext context, int participantCount) => Text(
        "Join $participantCount participant${participantCount == 1 ? "" : "s"}",
        style: Theme.of(context).textTheme.caption?.copyWith(
              fontSize: 14,
              color: kPrimaryColor300,
              height: 1.2,
            ),
      );
}
