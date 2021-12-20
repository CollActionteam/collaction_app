import 'package:flutter/material.dart';

import '../../../../../themes/constants.dart';
import 'commitment_avatar.dart';
import 'commitment_checkbox.dart';

class CommitmentCard extends StatelessWidget {
  final bool selected;
  final Function? onClickHandler;
  final int order;

  const CommitmentCard(
      {Key? key, this.selected = false, this.onClickHandler, this.order = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(color: kAlmostTransparent),
      ),
      color: selected ? kAlmostTransparent : kSecondaryColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CommitmentAvatar(),
            const SizedBox(width: 10),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vegan Diet',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'This is a description of what this commitment is about.',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: kPrimaryColor300,
                        ),
                  )
                ],
              ),
            ),
            CommitmentCheckbox(
              selected: selected,
              onClickHandler: onClickHandler,
              order: order,
            ),
          ],
        ),
      ),
    );
  }
}
