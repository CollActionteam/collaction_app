import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/spotlight/spot_light_bloc.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../../presentation/shared_widgets/accent_chip.dart';
import '../../routes/app_routes.gr.dart';
import '../../themes/constants.dart';

class CurrentAndUpcomingLayout extends StatelessWidget {
  final bool isCurrent;

  // the below crowdAction list is the first 3 that will be shown onthe homescreen
  // and hence need to be passed from home_page
  const CurrentAndUpcomingLayout({
    Key? key,
    this.isCurrent = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget fetched(List<CrowdAction> fetchedData) {
      return Column(
        children: fetchedData.isNotEmpty
            ? fetchedData
                .map(
                  (e) => Container(
                    height: 148,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () => context.router
                          .push(CrowdActionDetailsRoute(crowdAction: e)),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(e.image.toString()),
                                      fit: BoxFit.cover)),
                              margin: const EdgeInsets.only(left: 10),
                              height: 128,
                              width: 100,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: AccentChip(
                                      text: "Sign up now",
                                      leading: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 10, left: 10, right: 10),
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(16)),
                                  //     child: const Text('Sign up now')),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Text(
                                      e.name.toString(),
                                      softWrap: false,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 6,
                                        bottom: 10),
                                    child: Text(
                                      e.description.toString(),
                                      softWrap: false,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: kInactiveColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList()
            : [
                const Center(
                  child: Text(
                    'No crowdactions at the moment.',
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
      );
    }

    return BlocBuilder<SpotLightBloc, SpotLightState>(
      builder: (ctx, state) => SizedBox(
        width: MediaQuery.of(context).size.width,
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
                      isCurrent ? 'Currently running' : 'Upcoming',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 28.0),
                    ),
                    TextButton(
                      onPressed: () => context.router.push(isCurrent
                          ? const CrowdActionBrowseRoute()
                          : const CrowdActionBrowseRoute()),
                      child: const Text(
                        'View all',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                            color: kAccentColor),
                      ),
                    ),
                    // const SizedBox(height: 3),
                  ],
                ),
              ),
              state.maybeMap(
                  fetchingCrowdSpotLightActions: (_) => const Center(
                        child: CircularProgressIndicator(
                          color: kAccentColor,
                        ),
                      ),
                  spotLightCrowdActions: (fetchedCrowdaction) =>
                      fetched(fetchedCrowdaction.crowdActions),
                  spotLightCrowdActionsError: (failure) => Center(
                        child: Text(
                            'Error: ${failure.error.toString()} occured!! Please try again.'),
                      ),
                  orElse: () {
                    return const Text('Some error');
                  }),
              // state.maybeMap(
              //     fetchingCrowdActions: (_) => const Center(
              //             child: CircularProgressIndicator(
              //           color: kAccentColor,
              //         )),
              //     noCrowdActions: (_) => noCrowdAction(),
              //     fetched: (fetchedData) => fetched(fetchedData.crowdActions),
              //     orElse: () {
              //       return const Text('Blahblahblah');
              //     }),
              const SizedBox(height: 20)
            ]),
      ),
    );
  }
}
