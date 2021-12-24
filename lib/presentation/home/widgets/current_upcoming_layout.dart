import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/spotlight/spotlight_bloc.dart';
<<<<<<< HEAD
=======
import '../../../domain/crowdaction/crowdaction.dart';
import '../../../presentation/core/collaction_icons.dart';
import '../../../presentation/home/widgets/password_modal.dart';
>>>>>>> feat: add password modal to in spotlight crowdactions
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/content_placeholder.dart';
import '../../shared_widgets/micro_crowdaction_card.dart';
import '../../themes/constants.dart';

class CurrentAndUpcomingLayout extends StatefulWidget {
  final bool isCurrent;

  const CurrentAndUpcomingLayout({
    Key? key,
    this.isCurrent = true,
  }) : super(key: key);

  @override
  State<CurrentAndUpcomingLayout> createState() =>
      _CurrentAndUpcomingLayoutState();
}

class _CurrentAndUpcomingLayoutState extends State<CurrentAndUpcomingLayout> {
  @override
  Widget build(BuildContext context) {
    // TODO: Refactor to not use SpotlightBloc, we should generalize to only have ONE crowdaction bloc!!!!!
    return BlocBuilder<SpotlightBloc, SpotlightState>(
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
                    widget.isCurrent ? 'Currently running' : 'Upcoming',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.router.push(
                      widget.isCurrent
                          ? const CrowdActionBrowseRoute()
                          : const CrowdActionBrowseRoute(),
                    ),
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
              fetchingCrowdSpotLightActions: (_) => const Center(
                child: CircularProgressIndicator(
                  color: kAccentColor,
                ),
              ),
              spotLightCrowdActions: (fetchedData) => Column(
                children: [
                  ...fetchedData.crowdActions
                      .map(
                        (crowdAction) => MicroCrowdActionCard(
                          crowdAction,
                        ),
                      )
                      .toList(),
                ],
              ),
              spotLightCrowdActionsError: (failure) => const ContentPlaceholder(
                textColor: Colors.black,
              ),
              orElse: () => const SizedBox(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

  Widget _fetched(List<CrowdAction> fetchedData) {
    return Column(
      children: fetchedData
          .map(
            (e) => GestureDetector(
              onTap: () {
                if (e.passwordJoin != "") {
                  showPasswordModal(context, e);
                } else {
                  context.router.push(CrowdActionDetailsRoute(crowdAction: e));
                }
              },
              child: Container(
                height: 148,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                                image: NetworkImage(e.images.card.toString()),
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.only(left: 10),
                        height: 128,
                        width: 100,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AccentChip(
                                    text: "Sign up now",
                                    leading: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (e.passwordJoin != "")
                                    const Icon(CollactionIcons.lock),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  e.title.toString(),
                                  softWrap: false,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 6, bottom: 10),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
>>>>>>> feat: add password modal to in spotlight crowdactions
}
