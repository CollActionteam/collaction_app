import 'package:flutter/material.dart';

import '../../../../themes/constants.dart';

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
            child: BuildEmailRow(email: email),
          ),
        ],
      ),
    );
  }
}

class BuildEmailRow extends StatelessWidget {
  final String email;
  const BuildEmailRow({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 33,
          child: Row(
            children: [
              Text(
                email.isNotEmpty ? email : "No email",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor300,
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Spacer(),
              email.isNotEmpty
                  ? TextButton(
                      onPressed: () {},
                      child: Text(
                        "Change",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: kAccentColor,
                              fontFamily: 'Rubik',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ))
                  : TextButton(
                      onPressed: () {},
                      child: Text(
                        "Add",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: kAccentColor,
                              fontFamily: 'Rubik',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      )),
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
