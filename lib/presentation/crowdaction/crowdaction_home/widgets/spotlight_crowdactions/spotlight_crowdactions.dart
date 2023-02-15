import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/core.dart';
import '../../../../../domain/crowdaction/crowdaction.dart';
import '../../../../shared_widgets/crowdaction_card.dart';
import '../../../../shared_widgets/secondary_chip.dart';

part 'in_spotlight_header_empty.dart';

class SpotlightCrowdActions extends StatefulWidget {
  final List<CrowdAction> pages;
  const SpotlightCrowdActions({
    super.key,
    required this.pages,
  });

  @override
  State<SpotlightCrowdActions> createState() => _SpotlightCrowdActionsState();
}

class _SpotlightCrowdActionsState extends State<SpotlightCrowdActions> {
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
    if (widget.pages.isEmpty) {
      return const SpotlightEmptyHeader();
    }

    return Column(
      children: [
        ExpandablePageView.builder(
          itemBuilder: (ctx, index) {
            final crowdAction = widget.pages[index];
            return CrowdActionCard(
              crowdAction: crowdAction,
            );
          },
          itemCount: widget.pages.length,
          controller: _pageController,
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            DotsIndicator(
              position: _currentPage,
              dotsCount: widget.pages.length,
              decorator: DotsDecorator(
                activeColor: context.kTheme.accentColor,
                color: Color(0xFFCCCCCC),
                size: Size(12.0, 12.0),
                activeSize: Size(12.0, 12.0),
                spacing: EdgeInsets.all(8.0),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}
