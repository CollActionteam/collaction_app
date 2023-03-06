import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../shared_widgets/crowdaction_card.dart';
import '../../shared_widgets/no_ripple_behavior.dart';
import '../../themes/constants.dart';

class CrowdActionCarousel extends StatefulWidget {
  const CrowdActionCarousel({super.key});

  @override
  CrowdActionCarouselState createState() => CrowdActionCarouselState();
}

class CrowdActionCarouselState extends State<CrowdActionCarousel> {
  final _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpotlightBloc>(
      create: (context) => getIt<SpotlightBloc>()
        ..add(const SpotlightEvent.getSpotLightCrowdActions()),
      child:
          BlocBuilder<SpotlightBloc, SpotlightState>(builder: (context, state) {
        if (state is SpotLightCrowdActionsError) {
          return const Text('Something went wrong!');
        } else if (state is SpotLightCrowdActions) {
          final crowdActions = state.crowdActions;

          return Column(
            children: [
              ScrollConfiguration(
                behavior: NoRippleBehavior(),
                child: ExpandablePageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) => CrowdActionCard(
                    crowdAction: crowdActions[index],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DotsIndicator(
                dotsCount: crowdActions.length,
                position: _currentPage,
                decorator: const DotsDecorator(
                  color: kShadowColor,
                  size: Size(12.0, 12.0),
                  activeColor: kAccentColor,
                  activeSize: Size(12.0, 12.0),
                ),
                onTap: (position) {
                  _currentPage = position;
                  _pageController.animateToPage(
                    _currentPage.toInt(),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                },
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
