import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../infrastructure/core/injection.dart';
import '../../../../presentation/themes/constants.dart';
import '../../../shared_widgets/shimmers/title_shimmer_line.dart';

class ParticipationCountText extends StatelessWidget {
  const ParticipationCountText({
    super.key,
    required this.crowdAction,
    this.isEnded = false,
  });

  final CrowdAction? crowdAction;
  final bool isEnded;

  CrowdActionDetailsBloc getDetailsBloc(BuildContext context) {
    try {
      return BlocProvider.of<CrowdActionDetailsBloc>(context);
    } catch (_) {
      return getIt<CrowdActionDetailsBloc>()
        ..add(
          CrowdActionDetailsEvent.fetchCrowdAction(
            id: crowdAction!.id,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrowdActionDetailsBloc>.value(
      value: getDetailsBloc(context),
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
        "${!isEnded ? 'Join ' : ''}$participantCount ${participantCount > 1 ? 'people' : 'person'} ${!isEnded ? 'participating' : 'participated'}",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
              color: kPrimaryColor300,
              height: 1.2,
            ),
      );
}
