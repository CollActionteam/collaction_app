import 'package:flutter/material.dart';

import '../../../infrastructure/crowdaction/crowdaction_dto.dart';
import 'commitment_card.dart';

class CommitmentCardList extends StatefulWidget {
  final List<CommitmentOption> commitments;
  final Function(List<String>) onSelected;
  final Axis axis;

  /// Widget for easily creating a list of CommitmentCard(s)
  ///
  ///[commitments] The commitments the list is made up of
  ///
  /// [onSelected] Callback function for when a card is selected,
  /// returns the id of the selected commitment
  ///
  /// [axis] The direction of the list, defaults to [Axis.vertical]
  const CommitmentCardList({
    required this.commitments,
    required this.onSelected,
    this.axis = Axis.vertical,
    Key? key,
  }) : super(key: key);

  @override
  State<CommitmentCardList> createState() => _CommitmentCardListState();
}

class _CommitmentCardListState extends State<CommitmentCardList> {
  late List<CommitmentOption> _commitments;
  final List<String> _activeCommitments = [];

  @override
  void initState() {
    _commitments = List<CommitmentOption>.from(widget.commitments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, index) {
        final option = _commitments[index];

        return CommitmentCard(
          commitment: option,
          onSelected: _selectCommitment,
          onDeSelected: _deselectCommitment,
          active: _activeCommitments.contains(option.id),
        );
      },
      itemCount: _commitments.length,
      shrinkWrap: true,
    );
  }

  void _deselectCommitment(CommitmentOption option) {
    setState(() {
      // Remove from active commitments
      _activeCommitments.remove(option.id);
      // Check if has required
      final children = option.requires;
      // If yes - loop & deselect all children
      if (children != null) {
        _deselectAll(children);
      }
      // If is required child deselect & parent
      widget.onSelected(_activeCommitments);
    });
  }

  void _selectCommitment(CommitmentOption option) {
    setState(() {
      _activeCommitments.add(option.id);
      // Check if has required
      final children = option.requires;
      // If yes - Loop and check
      if (children != null) {
        _selectAll(children);
      }

      widget.onSelected(_activeCommitments);
    });
  }

  void _selectAll(List<CommitmentOption> commitments) {
    for (final commitment in _commitments) {
      if (commitments.contains(commitment)) {
        _activeCommitments.add(commitment.id);

        final children = commitment.requires;
        if (children != null) {
          _selectAll(children);
        }
      }
    }
  }

  void _deselectAll(List<CommitmentOption> commitments) {
    for (final commitment in _commitments) {
      if (commitments.contains(commitment)) {
        _activeCommitments.remove(commitment.id);

        final children = commitment.requires;
        if (children != null) {
          _deselectAll(children);
        }
      }
    }
  }
}
