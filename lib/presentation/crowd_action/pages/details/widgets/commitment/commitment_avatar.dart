import 'package:flutter/material.dart';

import '../../../../../themes/constants.dart';

class CommitmentAvatar extends StatelessWidget {
  final double elevation;

  const CommitmentAvatar({Key? key, this.elevation = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(40),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: kSecondaryColor,
        child: Image.asset('assets/images/diet.png'),
      ),
    );
  }
}
