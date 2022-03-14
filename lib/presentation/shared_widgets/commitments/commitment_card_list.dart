import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/subscription/subscription_bloc.dart';
import 'commitment_card.dart';

class CommitmentCardList extends StatelessWidget {
  /// Widget for easily creating a list of CommitmentCard(s)
  const CommitmentCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        final _commitments = state.deactivated
            ? state.commitments
                .where(
                  (commitment) =>
                      state.activeCommitments.contains(commitment.id),
                )
                .toList()
            : state.commitments;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) {
            final option = _commitments[index];

            return CommitmentCard(
              commitment: option,
              onSelected: state.deactivated
                  ? null
                  : (commitment) {
                      context
                          .read<SubscriptionBloc>()
                          .add(SubscriptionEvent.selectCommitment(commitment));
                    },
              onDeSelected: state.deactivated
                  ? null
                  : (commitment) {
                      context.read<SubscriptionBloc>().add(
                            SubscriptionEvent.deselectCommitment(commitment),
                          );
                    },
              active: !state.deactivated &&
                  state.activeCommitments.contains(option.id),
              deactivated: state.deactivated,
            );
          },
          itemCount: _commitments.length,
          shrinkWrap: true,
        );
      },
    );
  }
}
