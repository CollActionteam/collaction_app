import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/participation/participation_bloc.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../shimmers/commitment_card_shimmer.dart';
import 'commitment_card.dart';

class CommitmentCardList extends StatefulWidget {
  final bool isEnded;
  final List<Commitment>? commitments;
  final List<Commitment> selectedCommitments;

  /// Widget for easily creating a list of CommitmentCard(s)
  const CommitmentCardList({
    super.key,
    this.isEnded = false,
    required this.commitments,
    required this.selectedCommitments,
  });

  @override
  State<CommitmentCardList> createState() => _CommitmentCardListState();
}

class _CommitmentCardListState extends State<CommitmentCardList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipationBloc, ParticipationState>(
      builder: (context, state) {
        if (widget.commitments == null) {
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

        bool isParticipating = state is Participating;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            final option = widget.commitments![index];
            return CommitmentCard(
              key: Key(option.id),
              commitment: option,
              onSelected: isParticipating ? null : selectCommitment,
              onDeSelected: isParticipating ? null : deselectCommitment,
              active: widget.selectedCommitments.contains(option),
              deactivated: isParticipating || isBlocked(option),
              viewOnly: widget.isEnded,
            );
          },
          itemCount: widget.commitments!.length,
          shrinkWrap: true,
        );
      },
    );
  }

  void selectCommitment(Commitment commitment) {
    setState(() {
      widget.selectedCommitments.add(commitment);
      for (final id in commitment.blocks) {
        widget.selectedCommitments.removeWhere((c) => c.id == id);
      }
    });
  }

  void deselectCommitment(Commitment commitment) {
    setState(() {
      widget.selectedCommitments.removeWhere((c) => c.id == commitment.id);
    });
  }

  bool isBlocked(Commitment commitment) {
    return widget.selectedCommitments
        .any((c) => c.blocks.contains(commitment.id));
  }
}
