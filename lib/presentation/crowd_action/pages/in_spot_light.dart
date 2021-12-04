import 'package:collaction_app/application/crowdaction/spotlight/spot_light_bloc.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:collaction_app/presentation/crowd_action/pages/widgets/share_collaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/in_spotlight_header.dart';

class InSpotLightPage extends StatelessWidget {
  const InSpotLightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SpotLightBloc>()
        ..add(const SpotLightEvent.getSpotLightCrowdActions()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: const [
                InSpotLightHeader(),
                CurrentAndUpcomingLayout(),
                ShareCollActionCard(),
                CurrentAndUpcomingLayout(isCurrent: false)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
