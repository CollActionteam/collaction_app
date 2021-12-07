import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../shared_widgets/accent_action_chip.dart';
import '../../shared_widgets/crowdaction_card.dart';
import '../../shared_widgets/no_ripple_behavior.dart';
import '../../shared_widgets/secondary_chip.dart';
import '../../themes/constants.dart';

class CrowdActionCarousel extends StatefulWidget {
  const CrowdActionCarousel({Key? key}) : super(key: key);

  @override
  _CrowdActionCarouselState createState() => _CrowdActionCarouselState();
}

class _CrowdActionCarouselState extends State<CrowdActionCarousel> {
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
    final height = MediaQuery.of(context).size.height;
    final scaleFactor = height < 700
        ? height < 600
            ? 0.8
            : 0.9
        : 1.0;

    return BlocProvider<CrowdActionGetterBloc>(
      create: (context) => getIt<CrowdActionGetterBloc>()
        ..add(const CrowdActionGetterEvent.getMore(3)),
      child: BlocBuilder<CrowdActionGetterBloc, CrowdActionGetterState>(
        builder: (context, state) => state.when(
          initial: () => const CircularProgressIndicator(),
          noCrowdActions: () => const Text('No CrowdActions'),
          fetchingCrowdActions: () => const CircularProgressIndicator(),
          fetched: (crowdActions) => Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 400.0 * scaleFactor,
                child: ScrollConfiguration(
                  behavior: NoRippleBehavior(),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    itemBuilder: (context, index) => CrowdActionCard(
                      scaleFactor: scaleFactor,
                      title: crowdActions[index].title,
                      imagePath:
                          'https://collaction-production.s3.eu-central-1.amazonaws.com/7d50f62a-a73d-401e-a1d8-33a9e8817870.jpg', // TODO: Use crowdaction image
                      chips: [
                        // TODO: Use crowdaction chips
                        AccentActionChip(
                          () {},
                          text: 'Sign up now',
                          leading: const Image(
                              image: AssetImage(
                                  'assets/images/icons/add_icon.png')),
                        ),
                        const SecondaryChip(text: 'Sustainability'),
                        const SecondaryChip(text: 'Environment')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10 * scaleFactor),
              DotsIndicator(
                dotsCount: crowdActions.length,
                position: _currentPage,
                decorator: DotsDecorator(
                  color: kShadowColor,
                  size: Size(12.0 * scaleFactor, 12.0 * scaleFactor),
                  activeColor: kAccentColor,
                  activeSize: Size(12.0 * scaleFactor, 12.0 * scaleFactor),
                ),
                onTap: (position) {
                  _currentPage = position;
                  _pageController.animateToPage(_currentPage.toInt(),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
