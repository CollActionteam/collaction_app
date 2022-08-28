import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';

class BuildInformationTile extends StatelessWidget {
  final BuildInformation information;

  const BuildInformationTile({Key? key, required this.information})
      : super(key: key);

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
