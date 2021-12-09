import 'package:flutter/material.dart';

import '../../infrastructure/crowdaction/crowdaction_dto.dart';
import '../../presentation/themes/constants.dart';

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
  List<String> _activeCommitments = [];

  @override
  void initState() {
    _commitments = List<CommitmentOption>.from(widget.commitments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _commitments
          .map((option) => CommitmentCard(
                commitment: option,
                onSelected: (String selectedId) {
                  final actualCommitments = List<String>.from(_activeCommitments);

                  actualCommitments.add(option.id);
                    // Check if has required
                    final children = option.requires;
                    // If yes - Loop and check
                    if (children != null) {
                      actualCommitments.addAll(_selectAll(_commitments,children));
                    }

                    setState(() {
                      _activeCommitments = actualCommitments;
                    });

                },
                onDeSelected: (String deselectedId) {
                  setState(() {
                    // Remove from active commitments
                    _activeCommitments.remove(deselectedId);
                    // Check if has required
                    final children = option.requires;
                    // If yes - loop & deselect all children
                    if (children != null) {
                      _deselectAll(children);
                    }
                    // If is required child deselect & parent
                  });
                },
                active: _activeCommitments.contains(option.id),
              ))
          .toList(),
    );
  }

  List<String> _selectAll(List<CommitmentOption> allCommitments,List<CommitmentOption> childCommitments) {
    final _selectedCommitments = <String>[];
    for (final commitment in allCommitments) {
      if (childCommitments.contains(commitment)) {
        _selectedCommitments.add(commitment.id);

        final children = commitment.requires;
        if (children != null) {
          _selectedCommitments.addAll(_selectAll(allCommitments,children)) ;
        }
      }
    }

    return _selectedCommitments;
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

/// Creates a new CommitmentCard
///
/// [commitment] The commitment to be respresented
///
/// [onSelected] Callback function for when the card is selected,
/// returns the id of the selected commitment
class CommitmentCard extends StatelessWidget {
  const CommitmentCard({
    required this.commitment,
    required this.onSelected,
    required this.onDeSelected,
    Key? key,
    this.active = false,
  }) : super(key: key);

  final CommitmentOption commitment;
  final Function(String) onSelected;
  final Function(String) onDeSelected;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (!active) {
          onSelected(commitment.id);
        } else {
          onDeSelected(commitment.id);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: active ? kSecondaryTransparent : kAlmostTransparent,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kAlmostTransparent,
                ),
                alignment: Alignment.center,
                child: commitment.icon != null
                    ? Image.network(
                        commitment.icon!,
                        height: 30,
                      )
                    : Image.asset(
                        'assets/images/green_logo.png',
                        height: 30,
                      )),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              constraints: const BoxConstraints(
                maxHeight: 70,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commitment.label,
                    style: textTheme.headline6!.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    commitment.description,
                    style: textTheme.bodyText2!.copyWith(fontSize: 13),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              constraints: const BoxConstraints(
                minHeight: 40,
                minWidth: 40,
              ),
              decoration: BoxDecoration(
                color: active ? kPrimaryColor400 : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: active ? kPrimaryColor400 : kPrimaryColor200,
                  width: 3,
                ),
              ),
              child: Visibility(
                visible: active,
                child: const Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
