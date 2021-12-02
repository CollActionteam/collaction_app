import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/crowdaction/spotlight/spot_light_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../../presentation/crowd_action/pages/widgets/share_collaction_card.dart';
import '../../../presentation/home/widgets/current_upcoming_layout.dart';

import 'widgets/in_spotlight_header.dart';

class InSpotLightPage extends StatelessWidget {
  const InSpotLightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SpotLightBloc>()
        ..add(const SpotLightEvent.getSpotLightCrowdActions()),
      child: SingleChildScrollView(
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
    );
  }
}
