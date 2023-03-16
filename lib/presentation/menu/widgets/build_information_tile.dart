import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/settings/build_information/build_information_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../themes/constants.dart';

class BuildInformationTile extends StatelessWidget {
  const BuildInformationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuildInformationBloc>(
      create: (context) => getIt<BuildInformationBloc>()
        ..add(const BuildInformationEvent.fetch()),
      child: BlocBuilder<BuildInformationBloc, BuildInformationState>(
        builder: (context, state) {
          return state.when(
            loading: () => const SizedBox.shrink(),
            fetched: (buildInfo) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const SizedBox(
                    width: 120,
                    child: Image(
                        image: AssetImage('assets/images/collaction.png')),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Build ${buildInfo.buildNumber}',
                    style: const TextStyle(
                      color: kPrimaryColor100,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Version ${buildInfo.version}',
                    style: const TextStyle(
                      color: kPrimaryColor100,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Text(
                    'Stichting CollAction',
                    style: TextStyle(
                      color: kPrimaryColor100,
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  if (buildInfo.environment == 'development') ...[
                    Text(
                      'Environment ${buildInfo.environment!.toUpperCase()}',
                      style: const TextStyle(
                        color: kPrimaryColor100,
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
