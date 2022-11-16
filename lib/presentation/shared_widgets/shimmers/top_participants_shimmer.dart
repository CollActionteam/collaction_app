import 'package:flutter/material.dart';

import '../../themes/constants.dart';

class TopParticipantsShimmer extends StatelessWidget {
  const TopParticipantsShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: kSecondaryTransparent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Align(
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: kSecondaryTransparent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: kSecondaryTransparent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
