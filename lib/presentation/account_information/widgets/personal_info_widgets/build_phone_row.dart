import 'package:flutter/material.dart';

import '../../../themes/constants.dart';

class BuildPhoneRow extends StatelessWidget {
  final String? phoneNumber;
  const BuildPhoneRow({
    super.key,
    required this.phoneNumber,
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
                phoneNumber ?? "No Phone",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor300,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Contact us",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kAccentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Your phone number is used to sign-in, it is currently not possible to change it, if you need to migrate your account to a new phone number please contact us.",
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
