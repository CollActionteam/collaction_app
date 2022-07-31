import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/participation/participation_bloc.dart';
import 'package:collaction_app/presentation/shared_widgets/commitments/commitment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/crowdaction/crowdaction.dart';
import '../../../shared_widgets/pill_button.dart';
import '../../../themes/constants.dart';

class ConfirmParticipation extends StatelessWidget {
  final CrowdAction crowdAction;
  final List<CommitmentOption> selectedCommitments;

  const ConfirmParticipation({
    Key? key,
    required this.crowdAction,
    required this.selectedCommitments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipationBloc, ParticipationState>(
      bloc: BlocProvider.of<ParticipationBloc>(context),
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => ParticipationDialog(
            crowdAction: crowdAction,
            selectedCommitments: selectedCommitments,
            isLoading: state.mapOrNull(loading: (_) => true) ?? false,
          ),
          participating: (_) => ParticipationSuccess(),
        );
      },
    );
  }
}

class ParticipationSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              color: kSecondaryTransparent,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Participate",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 28,
          ),
          Text(
            "All set!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "You have successfully registered for this CrowdAction",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: kPrimaryColor400,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          PillButton(
            text: "Got it",
            onTap: () {
              context.router.pop();
            },
            margin: EdgeInsets.zero,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(maxWidth: 250),
            child: Text(
              "You can change your commitment until the CrowdAction starts",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: kPrimaryColor200,
                  ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class ParticipationDialog extends StatelessWidget {
  final CrowdAction crowdAction;
  final List<CommitmentOption> selectedCommitments;
  final bool isLoading;

  const ParticipationDialog({
    Key? key,
    required this.crowdAction,
    required this.selectedCommitments,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              color: kSecondaryTransparent,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Participate",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 80),
                  child: Text(
                    "You’re almost there! You’ve selected the displayed commitment${selectedCommitments.length > 1 ? 's' : ''} to stick to through this CrowdAction. By clicking “Confirm” you will officially commit to this CrowdAction.",
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: kPrimaryColor400,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Your commitment${selectedCommitments.length > 1 ? 's' : ''}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: kPrimaryColor300, fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final option = selectedCommitments[index];
                    return CommitmentCard(
                      key: Key(option.id),
                      commitment: option,
                      active: true,
                    );
                  },
                  itemCount: selectedCommitments.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PillButton(
            text: "Confirm",
            isLoading: isLoading,
            isEnabled: selectedCommitments.isNotEmpty,
            margin: EdgeInsets.zero,
            onTap: () {
              BlocProvider.of<ParticipationBloc>(context).add(
                ParticipationEvent.toggleParticipation(
                  crowdActionId: crowdAction.id,
                  commitmentOptions:
                      selectedCommitments.map((c) => c.id).toList(),
                ),
              );
            },
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
  }
}
