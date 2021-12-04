import 'package:collaction_app/application/crowdaction/subscribe/subscribe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widgets/in_spotlight_header.dart';
import './widgets/share_collaction_card.dart';
import '../../../application/crowdaction/spotlight/spot_light_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../home/widgets/current_upcoming_layout.dart';

class InSpotLightPage extends StatelessWidget {
  const InSpotLightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt<SpotLightBloc>()
              ..add(const SpotLightEvent.getSpotLightCrowdActions())),
        BlocProvider(
          create: (_) => getIt<SubscribeBloc>(),
        )
      ],
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
