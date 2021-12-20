import 'package:flutter/material.dart';

import '../../../../../domain/crowdaction/crowdaction.dart';
import '../../../../themes/constants.dart';

class CrowdActionCreatedByWidget extends StatelessWidget {
  final CrowdAction crowdAction;

  const CrowdActionCreatedByWidget({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "This CrowdAction was created by",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              //! TODO: Redirect to creator's profile
            },
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 26,
                  foregroundImage: AssetImage('assets/images/user.png'),
                ),
                SizedBox(
                  width: 16,
                ),
                // TODO - Display creator name & profile image
                Text(
                  "Barbara",
                  style: TextStyle(
                    fontSize: 17,
                    color: kPrimaryColor400,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
