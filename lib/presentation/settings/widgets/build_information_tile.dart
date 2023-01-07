import 'package:flutter/material.dart';

import '../../../domain/settings/build_information.dart';
import '../../themes/constants.dart';

class BuildInformationTile extends StatelessWidget {
  final BuildInformation information;

  const BuildInformationTile({super.key, required this.information});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const SizedBox(
          width: 56,
          child: Image(image: AssetImage('assets/images/build_info.png')),
        ),
        const SizedBox(height: 5),
        Text(
          'Build ${information.buildNumber}',
          style: const TextStyle(
            color: kPrimaryColor100,
            fontSize: 17,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Version ${information.version}',
          style: const TextStyle(
            color: kPrimaryColor100,
            fontSize: 17,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Stichting CollAction',
          style: TextStyle(
            color: kPrimaryColor100,
            fontSize: 17,
            fontWeight: FontWeight.w300,
          ),
        ),
        if (information.environment == 'development') ...[
          const SizedBox(height: 5),
          Text(
            'Environment ${information.environment!.toUpperCase()}',
            style: const TextStyle(
              color: kPrimaryColor100,
              fontSize: 17,
              fontWeight: FontWeight.w300,
            ),
          ),
        ]
      ],
    );
  }
}
