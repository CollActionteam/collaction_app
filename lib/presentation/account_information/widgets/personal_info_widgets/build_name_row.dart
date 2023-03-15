import '../../../themes/constants.dart';
import 'package:flutter/material.dart';

import 'change_name_dialog.dart';

class BuildNameRow extends StatelessWidget {
  final String firstName;
  final String lastName;

  BuildNameRow({
    super.key,
    required this.firstName,
    required this.lastName,
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
                '$firstName $lastName',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor300,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              ChangeNameDialog(
                firstName: firstName,
                lastName: lastName,
              ),
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
