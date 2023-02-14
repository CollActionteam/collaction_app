import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../../core/core.dart';
import '../../../infrastructure/core/injection.dart';
import '../../shared_widgets/crowdaction_card.dart';
import '../../shared_widgets/no_ripple_behavior.dart';

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
      child: BlocBuilder<SpotlightBloc, SpotlightState>(
        builder: (context, state) => state.when(
          initial: () => const CircularProgressIndicator(),
          fetchingCrowdSpotLightActions: () {
            // TODO: Shimmer
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          spotLightCrowdActionsError: (failure) {
            return const Text('Something went wrong!');
          },
          spotLightCrowdActions: (crowdActions) => Column(
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
                decorator: DotsDecorator(
                  color: context.colors.shadowColor!,
                  size: Size(12.0, 12.0),
                  activeColor: context.colors.accentColor,
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
          ),
        ),
      ),
    );
  }
}
