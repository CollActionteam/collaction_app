import 'package:flutter/material.dart';

import '../../../../../themes/constants.dart';

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
