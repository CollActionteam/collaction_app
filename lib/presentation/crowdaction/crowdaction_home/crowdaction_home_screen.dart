import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../home/widgets/current_upcoming_layout.dart';
import 'widgets/in_spotlight_header.dart';
import 'widgets/share_collaction_card.dart';

class CrowdActionHomeScreen extends StatelessWidget {
  const CrowdActionHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SpotlightBloc>()
        ..add(const SpotlightEvent.getSpotLightCrowdActions()),
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
