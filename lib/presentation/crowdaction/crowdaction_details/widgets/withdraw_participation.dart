import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/crowdaction/crowdaction.dart';
import '../../../../application/participation/participation_bloc.dart';
import '../../../../core/core.dart';
import '../../../shared_widgets/pill_button.dart';

class WithdrawParticipation extends StatelessWidget {
  final ParticipationBloc participationBloc;
  final CrowdAction crowdAction;
  final bool isParticipating;

  const WithdrawParticipation({
    super.key,
    required this.participationBloc,
    required this.crowdAction,
    required this.isParticipating,
  });

  @override
  Widget build(BuildContext context) {
    return isParticipating
        ? GestureDetector(
            onTap: () => _withdrawParticipationModal(context),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Cancel my participation',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: context.kTheme.successColor,
                    ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  void _withdrawParticipationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return BlocBuilder<ParticipationBloc, ParticipationState>(
          bloc: participationBloc,
          builder: (context, state) {
            return state.maybeWhen(
              notParticipating: () {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 60.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: context.kTheme.secondaryTransparent,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        crowdAction.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        "We are sad to see you withdraw!",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PillButton(
                        text: "Got It",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        margin: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
              orElse: () {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 60.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: context.kTheme.secondaryTransparent,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "We’d love to keep you",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "You are about to cancel your participation. You are free to sign up for this CrowdAction again any time before it starts.",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: context.kTheme.primaryColor400,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PillButton(
                        text: "Cancel my participation",
                        isLoading:
                            state.mapOrNull(loading: (_) => true) ?? false,
                        onTap: () => participationBloc.add(
                          ParticipationEvent.toggleParticipation(
                            crowdActionId: crowdAction.id,
                          ),
                        ),
                        margin: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: TextButton(
                          onPressed: () => context.router.pop(),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
