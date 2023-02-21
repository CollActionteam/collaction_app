import 'package:flutter/material.dart';

import '../../../../../themes/constants.dart';
import 'change_country_dialog.dart';

class BuildCountryRow extends StatelessWidget {
  final String countryName;
  const BuildCountryRow({super.key, required this.countryName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 33,
          child: Row(
            children: [
              Text(
                countryName.isNotEmpty ? countryName : "No country",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor300,
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Spacer(),
              ChangeCountryDialog(countryName: countryName),
            ],
          ),
        ),
        SizedBox(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  "Your country is used to suggest more relevant crowdactions for you. It is also displayed on your profile, and when participating in the community.",
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
