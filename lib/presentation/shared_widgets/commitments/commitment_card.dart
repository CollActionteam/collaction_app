import 'package:flutter/material.dart';

import '../../../infrastructure/crowdaction/crowdaction_dto.dart';
import '../../themes/constants.dart';

/// Creates a new CommitmentCard
///
/// [commitment] The commitment to be represented
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
  final Function(CommitmentOption) onSelected;
  final Function(CommitmentOption) onDeSelected;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (!active) {
          onSelected(commitment);
        } else {
          onDeSelected(commitment);
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
