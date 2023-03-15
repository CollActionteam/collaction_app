import 'package:flutter/material.dart';

import '../../../themes/constants.dart';

class BuildEmailRow extends StatelessWidget {
  const BuildEmailRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // TODO: Email
                "No email",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor300,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              // TODO: Add/Change email
              // email != null
              //     ? GestureDetector(
              //         onTap: () {},
              //         child: Text(
              //           "Change",
              //           style:
              //               Theme.of(context).textTheme.bodySmall?.copyWith(
              //                     color: kAccentColor,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //         ))
              //     : GestureDetecotr(
              //         onTap: () {},
              //         child: Text(
              //           "Add",
              //           style:
              //               Theme.of(context).textTheme.bodySmall?.copyWith(
              //                     color: kAccentColor,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //         ),
              //       ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Your full name is displayed on your profile, when you participate in crowdactions, and when participating in the community.",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: kPrimaryColor300,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
