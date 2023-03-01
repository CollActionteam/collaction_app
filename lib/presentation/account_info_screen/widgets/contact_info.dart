import 'package:flutter/material.dart';

import '../../themes/constants.dart';
import 'contact_info_widgets/build_email_row.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});
  final String email = "jane.alfred98@gmail.com";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Contact information",
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
            child: BuildEmailRow(),
          ),
        ],
      ),
    );
  }
}
