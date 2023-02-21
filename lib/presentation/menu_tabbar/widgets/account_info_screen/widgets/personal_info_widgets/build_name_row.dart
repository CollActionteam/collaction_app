import '../../../../../themes/constants.dart';
import 'package:flutter/material.dart';

import 'change_name_dialog.dart';

class BuildNameRow extends StatelessWidget {
  final String name;
  const BuildNameRow({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 33,
          child: Row(
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor300,
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Spacer(),
              ChangeNameDialog(),
            ],
          ),
        ),
        SizedBox(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  "Your full name is displayed on your profile, when you participate in crowdactions, and when participating in the community.",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: kPrimaryColor300,
                        fontFamily: 'Rubik',
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
