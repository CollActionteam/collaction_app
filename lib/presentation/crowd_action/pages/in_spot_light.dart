import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widgets/in_spotlight_header.dart';
import './widgets/share_collaction_card.dart';
import '../../../application/crowdaction/spotlight/spot_light_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../../presentation/themes/constants.dart';
import '../../home/widgets/current_upcoming_layout.dart';

class InSpotLightPage extends StatelessWidget {
  const InSpotLightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SpotLightBloc>()
        ..add(const SpotLightEvent.getSpotLightCrowdActions()),
      child: Stack(children: [
        SingleChildScrollView(
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
        Positioned(
          right: 0,
          top: 80,
          child: ElevatedButton(
            onPressed: () => context.router.push(SettingsRoute()),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kSecondaryColor),
                elevation: MaterialStateProperty.all(4),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
                fixedSize: MaterialStateProperty.all(
                  const Size(40, 40),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.all(8))),
            child: const ImageIcon(
              AssetImage(
                'assets/images/icons/settings.png',
              ),
              color: kPrimaryColor300,
            ),
          ),
        ),
      ]),
    );
  }
}
