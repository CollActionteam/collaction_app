import 'package:flutter/material.dart';

import '../../../../../themes/constants.dart';
import 'commitment_card.dart';

class CommitmentsWidget extends StatefulWidget {
  const CommitmentsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CommitmentsWidget> createState() => _CommitmentsWidgetState();
}

class _CommitmentsWidgetState extends State<CommitmentsWidget> {
  late int _selectedCommitment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCommitment = 0;
  }

  void handleClick(int inputCommitmentNumber) {
    setState(() {
      _selectedCommitment = _selectedCommitment == inputCommitmentNumber
          ? 0
          : inputCommitmentNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: kSecondaryColor,
        child: Column(
          children: [
            Text(
              'My commitments',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Short description about what the commitments are and how you can select/deselect them',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: kPrimaryColor300,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: CommitmentCard(
                onClickHandler: handleClick,
                selected: _selectedCommitment == 1,
                order: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: CommitmentCard(
                onClickHandler: handleClick,
                selected: _selectedCommitment == 2,
                order: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: CommitmentCard(
                onClickHandler: handleClick,
                selected: _selectedCommitment == 3,
                order: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
