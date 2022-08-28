import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../home/widgets/current_upcoming_layout.dart';
import '../../themes/constants.dart';
import 'widgets/in_spotlight_header.dart';
import 'widgets/share_collaction_card.dart';

class CrowdActionHomeScreen extends StatelessWidget {
  const CrowdActionHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpotlightBloc>.value(
      value: BlocProvider.of<SpotlightBloc>(context)
        ..add(const SpotlightEvent.getSpotLightCrowdActions()),
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => BlocProvider.of<SpotlightBloc>(context)
                .add(const SpotlightEvent.getSpotLightCrowdActions()),
            color: kAccentColor,
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: const [
                    InSpotLightHeader(),
                    CurrentAndUpcomingLayout(),
                    SizedBox(height: 20),
                    ShareCollActionCard(),
                    SizedBox(height: 20),
                    CurrentAndUpcomingLayout(isCurrent: false)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
