import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../../shared_widgets/content_placeholder.dart';
import '../../../shared_widgets/crowdaction_card.dart';
import '../../../themes/constants.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: kPrimaryColor400,
          width: constraints.maxWidth,
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.only(left: 12, top: 8),
                child: Text(
                  sectionHeadingText(),
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<SpotlightBloc, SpotlightState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    fetchingCrowdSpotLightActions: () {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kAccentColor,
                        ),
                      );
                    },
                    spotLightCrowdActionsError: (_) {
                      return const ContentPlaceholder(
                        textColor: Colors.white,
                      );
                    },
                    spotLightCrowdActions: (_pages) {
                      return Column(
                        children: [
                          ExpandablePageView.builder(
                            itemBuilder: (ctx, index) {
                              final crowdAction = _pages[index];
                              return CrowdActionCard(
                                crowdAction: crowdAction,
                              );
                            },
                            itemCount: _pages.length,
                            controller: _pageController,
                          ),
                          const SizedBox(height: 5),
                          Row(
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
                        ],
                      );
                    },
                    orElse: () => const SizedBox(),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  String sectionHeadingText() {
    final _month = DateFormat.MMMM().format(DateTime.now());
    return "$_month's CrowdActions";
  }
}
