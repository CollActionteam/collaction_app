import 'package:flutter/material.dart';

import '../../../../domain/core/location.dart';
import '../../../themes/constants.dart';
import 'change_country_dialog.dart';

class BuildCountryRow extends StatelessWidget {
  final Location? location;

  const BuildCountryRow({
    super.key,
    required this.location,
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
                '${location?.name ?? "No"}, ${location?.code ?? "Country"}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kPrimaryColor300,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              ChangeCountryDialog(location: location),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Your country is used to suggest more relevant crowdactions for you. It is also displayed on your profile, and when participating in the community.",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: kPrimaryColor300,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                  maxLines: 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
