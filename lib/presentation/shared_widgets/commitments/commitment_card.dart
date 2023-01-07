import 'package:flutter/material.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../themes/constants.dart';

/// Creates a new CommitmentCard
///
/// [commitment] The commitment to be represented
///
/// [onSelected] Callback function for when the card is selected,
/// returns the id of the selected commitment
class CommitmentCard extends StatelessWidget {
  final CommitmentOption commitment;
  final Function(CommitmentOption)? onSelected;
  final Function(CommitmentOption)? onDeSelected;
  final bool active;
  final bool deactivated;
  final bool viewOnly;

  const CommitmentCard({
    required this.commitment,
    this.onSelected,
    this.onDeSelected,
    super.key,
    this.active = false,
    this.deactivated = false,
    this.viewOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: viewOnly
          ? null
          : () {
              if (!active && !deactivated) {
                onSelected?.call(commitment);
              } else {
                onDeSelected?.call(commitment);
              }
            },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: active ? kAlmostTransparent : kSecondaryColor,
          border: active
              ? Border.all(color: Colors.transparent)
              : Border.all(color: kPrimaryColor0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kSecondaryColor,
              ),
              alignment: Alignment.center,
              child: Icon(
                commitment.icon,
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
                    commitment.label,
                    style: textTheme.caption!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: deactivated ? kPrimaryColor300 : kPrimaryColor400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (commitment.description != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      commitment.description!,
                      style: textTheme.caption!.copyWith(
                        fontSize: 13,
                        color:
                            deactivated ? kPrimaryColor200 : kPrimaryColor300,
                      ),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]
                ],
              ),
            ),
            const Spacer(),
            if ((!deactivated || (deactivated && active)) && !viewOnly) ...[
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 32,
                  maxWidth: 32,
                  minHeight: 32,
                  minWidth: 32,
                ),
                decoration: BoxDecoration(
                  color: active
                      ? kPrimaryColor400.withAlpha(deactivated ? 50 : 255)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: active
                        ? kPrimaryColor400.withAlpha(deactivated ? 0 : 255)
                        : kPrimaryColor200,
                    width: 3,
                  ),
                ),
                child: Opacity(
                  opacity: deactivated ? 0.5 : 1,
                  child: const Icon(
                    Icons.check,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              )
            ] else ...[
              const SizedBox(height: 32, width: 32),
            ]
          ],
        ),
      ),
    );
  }
}
