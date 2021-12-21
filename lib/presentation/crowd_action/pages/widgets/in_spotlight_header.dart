import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/crowdaction/spotlight/spot_light_bloc.dart';
import '../../../../domain/crowdaction/participant.dart';
import '../../../routes/app_routes.gr.dart';
import '../../../shared_widgets/accent_chip.dart';
import '../../../shared_widgets/crowdaction_card.dart';
import '../../../themes/constants.dart';
import '../../utils/crowd_action.ext.dart';

class InSpotLightHeader extends StatefulWidget {
  const InSpotLightHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<InSpotLightHeader> createState() => _InSpotLightHeaderState();
}

class _InSpotLightHeaderState extends State<InSpotLightHeader> {
  final _pageController = PageController();
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(
      () => setState(() => _currentPage = _pageController.page!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: kPrimaryColor400,
          margin: const EdgeInsets.only(bottom: 20),
          child: BlocBuilder<SpotLightBloc, SpotLightState>(
            builder: (context, state) {
              return state.maybeWhen(
                fetchingCrowdSpotLightActions: () {
                  return const CircularProgressIndicator(
                    color: kAccentColor,
                  );
                },
                spotLightCrowdActionsError: (_) {
                  // TODO - Implement screen with missing spot lights
                  return const Text("Error");
                },
                spotLightCrowdActions: (_pages) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(12, 50, 12, 12),
                        child: Text(
                          "In the spotlight",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                      ),
                      ExpandablePageView.builder(
                        itemBuilder: (ctx, index) {
                          final crowdAction = _pages[index];
                          return CrowdActionCard(
                            title: crowdAction.name,
                            imagePath: crowdAction.image ?? "",
                            chips: [
                              GestureDetector(
                                onTap: () {
                                  // TODO - Sign up, to crowd action
                                },
                                child: const AccentChip(
                                  text: "Sign up now",
                                  leading: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ...crowdAction.toChips()
                            ],
                            participants: sampleParticipants,
                            totalParticipants: crowdAction.numParticipants,
                            onTap: () => context.router.push(
                              CrowdActionDetailsRoute(
                                crowdAction: crowdAction,
                              ),
                            ),
                          );
                        },
                        itemCount: _pages.length,
                        controller: _pageController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            DotsIndicator(
                              position: _currentPage,
                              dotsCount: _pages.length,
                              decorator: const DotsDecorator(
                                activeColor: kAccentColor,
                                color: Color(0xFFCCCCCC),
                                size: Size(12.0, 12.0),
                                activeSize: Size(12.0, 12.0),
                                spacing: EdgeInsets.all(8.0),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                orElse: () => const SizedBox(),
              );
            },
          ),
        ),
      ],
    );
  }
}
