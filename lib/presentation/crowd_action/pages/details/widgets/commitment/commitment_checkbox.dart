import 'package:flutter/material.dart';

import '../../../../../themes/constants.dart';

class CommitmentCheckbox extends StatelessWidget {
  final bool selected;
  final Function? onClickHandler;
  final int order;

  const CommitmentCheckbox(
      {Key? key, this.selected = false, this.onClickHandler, this.order = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: selected ? kPrimaryColor400 : kSecondaryColor,
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: selected ? kSecondaryColor : kPrimaryColor200,
        ),
      ),
      child: IconButton(
        onPressed: () {
          //! TODO: Select this commitment
          onClickHandler!(order);
        },
        icon: Image.asset(
          'assets/images/icons/check.png',
          color: kSecondaryColor,
          height: 30,
        ),
      ),
    );
  }
}
