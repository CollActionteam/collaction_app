import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../infrastructure/core/injection.dart';
import '../crowd_action/widgets/custom_scrollphysics.dart';
import '../crowd_action/widgets/full_crowdaction_card.dart';
import '../routes/app_routes.gr.dart';
import '../themes/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 23.0, horizontal: 23.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upcoming crowdactions',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.0),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.router.push(const CrowdActionBrowseRoute()),
                      child: const Text(
                        'View all',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: kIrisColor),
                      ),
                    ),
                  ],
                ),
                const CrowdActionCarousel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CrowdActionCarousel extends StatefulWidget {
  const CrowdActionCarousel({Key? key}) : super(key: key);

  @override
  _CrowdActionCarouselState createState() => _CrowdActionCarouselState();
}

class _CrowdActionCarouselState extends State<CrowdActionCarousel> {
  final _pageController = PageController(viewportFraction: 0.85);
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const CustomScrollPhysics(
                    itemDimension: 362,
                  ),
                  controller: _pageController,
                  itemCount: crowdActions.length,
                  itemBuilder: (context, index) => SizedBox(
                    height: 350,
                    width: 350,
                    child: FullCrowdActionCard(
                      crowdActions[index],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DotsIndicator(
                dotsCount: crowdActions.length,
                position: _currentPage,
                decorator: const DotsDecorator(
                  color: kDisabledButtonColor,
                  activeColor: kIrisColor,
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
