import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/content_placeholder.dart';
import '../../shared_widgets/micro_crowdaction_card.dart';
import '../../shared_widgets/micro_crowdaction_card_loading.dart';
import '../../themes/constants.dart';

class CurrentAndUpcomingLayout extends StatefulWidget {
  final bool isCurrent;

  const CurrentAndUpcomingLayout({
    super.key,
    this.isCurrent = true,
  });

  @override
  State<CurrentAndUpcomingLayout> createState() =>
      _CurrentAndUpcomingLayoutState();
}

class _CurrentAndUpcomingLayoutState extends State<CurrentAndUpcomingLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<SpotlightBloc>(context),
      child: BlocBuilder<SpotlightBloc, SpotlightState>(
        builder: (ctx, state) => LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.isCurrent ? 'Currently running' : 'Upcoming',
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor400,
                                  ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.router.push(CrowdActionBrowseRoute()),
                          child: const Text(
                            'View all',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                              color: kAccentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  state.maybeMap(
                    fetchingCrowdSpotLightActions: (_) => _loading(),
                    spotLightCrowdActions: (fetchedData) {
                      if (fetchedData.crowdActions.isEmpty) {
                        return _loading();
                      }

                      return Column(
                        children: [
                          ...fetchedData.crowdActions
                              .map(
                                (crowdAction) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  child: MicroCrowdActionCard(crowdAction),
                                ),
                              )
                              .toList(),
                        ],
                      );
                    },
                    spotLightCrowdActionsError: (failure) =>
                        const ContentPlaceholder(
                      textColor: Colors.black,
                    ),
                    orElse: () => const SizedBox(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _loading() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: MicroCrowdActionCardLoading(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: MicroCrowdActionCardLoading(),
        ),
      ],
    );
  }
}
