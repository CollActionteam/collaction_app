import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import 'commitment_card.dart';

class CommitmentCardList extends StatefulWidget {
  final List<CommitmentOption> commitments;
  final Function(List<String>) onSelected;
  final List<String> active;
  final Axis axis;
  final bool readOnly;

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
    this.active = const <String>[],
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<CommitmentCardList> createState() => CommitmentCardListState();
}

class CommitmentCardListState extends State<CommitmentCardList> {
  late List<CommitmentOption> _commitments;
  late List<String> _activeCommitments;

  @override
  void initState() {
    super.initState();
    _commitments = List<CommitmentOption>.from(widget.commitments);
    _activeCommitments = List<String>.from(widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, index) {
        final option = _commitments[index];

        return CommitmentCard(
          commitment: option,
          onSelected: widget.readOnly ? null : _selectCommitment,
          onDeSelected: widget.readOnly ? null : _deselectCommitment,
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

      // Recursively deselect all parents
      for (final commitment in _commitments
          .where((commitment) => _activeCommitments.contains(commitment.id))) {
        if (commitment.requires?.contains(option) == true) {
          _deselectCommitment(commitment);
        }
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
        _activeCommitments = _activeCommitments.toSet().toList();

        final children = commitment.requires;
        if (children != null) {
          _selectAll(children);
        }
      }
    }
  }

  void selectCommitments(List<String> commitments) {
    _activeCommitments.addAll(commitments);

    setState(() {
      _activeCommitments = _activeCommitments.toSet().toList();
    });
  }
}
