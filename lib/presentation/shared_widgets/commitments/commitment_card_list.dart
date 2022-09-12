import 'package:collaction_app/application/participation/participation_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/presentation/shared_widgets/shimmers/commitment_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'commitment_card.dart';

class CommitmentCardList extends StatefulWidget {
  final List<CommitmentOption>? commitmentOptions;
  final List<CommitmentOption> selectedCommitments;

  /// Widget for easily creating a list of CommitmentCard(s)
  const CommitmentCardList({
    Key? key,
    required this.commitmentOptions,
    required this.selectedCommitments,
  }) : super(key: key);

  @override
  State<CommitmentCardList> createState() => _CommitmentCardListState();
}

class _CommitmentCardListState extends State<CommitmentCardList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipationBloc, ParticipationState>(
      builder: (context, state) {
        if (widget.commitmentOptions == null) {
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            children: const [
              CommitmentCardShimmer(),
              CommitmentCardShimmer(),
              CommitmentCardShimmer(),
            ],
          );
        }

        bool isParticipating = false;

        state.mapOrNull(
          participating: (_) => isParticipating = true,
        );

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            final option = widget.commitmentOptions![index];
            return CommitmentCard(
              key: Key(option.id),
              commitment: option,
              onSelected: isParticipating ? null : selectCommitment,
              onDeSelected: isParticipating ? null : deselectCommitment,
              active: widget.selectedCommitments.contains(option),
              deactivated: isParticipating || isBlocked(option),
            );
          },
          itemCount: widget.commitmentOptions!.length,
          shrinkWrap: true,
        );
      },
    );
  }

  void selectCommitment(CommitmentOption commitment) {
    setState(() {
      widget.selectedCommitments.add(commitment);
      for (final id in commitment.blocks) {
        widget.selectedCommitments.removeWhere((c) => c.id == id);
      }
    });
  }

  void deselectCommitment(CommitmentOption commitment) {
    setState(() {
      widget.selectedCommitments.removeWhere((c) => c.id == commitment.id);
    });
  }

  bool isBlocked(CommitmentOption commitment) {
    return widget.selectedCommitments
        .any((c) => c.blocks.contains(commitment.id));
  }
}
