import 'package:flutter/material.dart';

import '../../../../themes/constants.dart';

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
          child: BuildNameRow(name: name),
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
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Change",
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

class BuildPhoneRow extends StatelessWidget {
  final String phoneNumber;
  const BuildPhoneRow({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 33,
          child: Row(
            children: [
              Text(
                phoneNumber,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor300,
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Contact us",
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
                  "Your phone number is used to sign-in, it is currently not possible to change it, if you need to migrate your account to a new phone number please contact us.",
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
              countryName.isNotEmpty
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
                      child: Text("Add",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: kAccentColor,
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                  ))),
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
