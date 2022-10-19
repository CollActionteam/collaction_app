import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/commitment/commitment.dart';
import '../../presentation/themes/constants.dart';
import '../core/collaction_icons.dart';

class CommitmentCardList extends StatelessWidget {
  final List<Commitment> commitments;
  final Function(int) onSelected;
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Build Commitment cards from the provided list of commitments
    final List<CommitmentCard> cards = commitments
        .map(
          (commitment) => CommitmentCard(
            commitment: commitment,
            onSelected: onSelected,
          ),
        )
        .toList();

    // Show horizontally or vertically
    if (axis == Axis.horizontal) {
      return Row(
        children: cards,
      );
    } else {
      return Column(
        children: cards,
      );
    }
  }
}

/// Creates a new CommitmentCard
///
/// [commitment] The commitment to be respresented
///
/// [onSelected] Callback function for when the card is selected,
/// returns the id of the selected commitment
class CommitmentCard extends StatefulWidget {
  const CommitmentCard({
    required this.commitment,
    required this.onSelected,
    super.key,
  });

  final Commitment commitment;
  final Function(int) onSelected;

  @override
  _CommitmentCardState createState() => _CommitmentCardState();
}

class _CommitmentCardState extends State<CommitmentCard> {
  late bool active;

  @override
  void initState() {
    super.initState();
    active = widget.commitment.checked;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        widget.onSelected(widget.commitment.id);
        setState(() {
          active = !active;
        });
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
              child: widget.commitment.icon != null
                  ? CachedNetworkImage(
                      imageUrl: widget.commitment.icon!,
                      placeholder: (context, url) => const Icon(
                        CollactionIcons.collaction,
                        color: kAccentColor,
                        size: 30,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        CollactionIcons.collaction,
                        color: kAccentColor,
                        size: 30,
                      ),
                      height: 30,
                    )
                  : const Icon(
                      CollactionIcons.collaction,
                      color: kAccentColor,
                      size: 30,
                    ),
            ),
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
                    widget.commitment.title,
                    style: textTheme.headline6!.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.commitment.description != null)
                    Text(
                      widget.commitment.description!,
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
