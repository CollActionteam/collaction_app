import 'personal_info_widgets/build_country_row.dart';
import 'personal_info_widgets/build_phone_row.dart';
import 'package:flutter/material.dart';

import '../../../../themes/constants.dart';
import 'personal_info_widgets/build_name_row.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});
  final String name = "Jane Alfred";
  final String phoneNumber = "+31 612345678";
  final String countryName = "The Netherlands, NL";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Personal information",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor300,
                  fontSize: 16,
                  fontFamily: 'Rubik'),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: BuildNameRow(
            name: name,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: BuildPhoneRow(phoneNumber: phoneNumber),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: BuildCountryRow(countryName: countryName),
        ),
      ],
    );
  }
}
