import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../domain/crowdaction/participant.dart';
import '../../../routes/app_routes.gr.dart';
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
  late List<CrowdAction> _pages;
  final _pageController = PageController();
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();

    /// TODO - Replace with dynamic data
    _pages = [
      CrowdAction(
        name: "This is the headline for the first crowd action",
        image: "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
        description:
            "Een maand zonder plastic wegwerpproducten en plastic verpakkingen: het klinkt onmogelijk of onaantrekkelijk, maar het Plasticdieet bewijst het tegendeel. Want wees nou eerlijk, heb je echt dat plastic flesje water of dat plastic roerstaafje voor je koffie nodig?",
        start: DateTime.now(),
        end: DateTime.now(),
        category: "Sustainability",
        subCategory: "Community",
        numParticipants: 32,
      ),
      CrowdAction(
        name: "This is the headline for the second crowd action",
        image: "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
        description:
            "Een maand zonder plastic wegwerpproducten en plastic verpakkingen: het klinkt onmogelijk of onaantrekkelijk, maar het Plasticdieet bewijst het tegendeel. Want wees nou eerlijk, heb je echt dat plastic flesje water of dat plastic roerstaafje voor je koffie nodig?",
        start: DateTime.now(),
        end: DateTime.now(),
        category: "Sustainability",
        subCategory: "Community",
        numParticipants: 30,
      ),
      CrowdAction(
        name: "This is the headline for the third crowd action",
        image: "https://i.postimg.cc/fLp5kBVQ/fruits-and-vegetables.jpg",
        description:
            "Een maand zonder plastic wegwerpproducten en plastic verpakkingen: het klinkt onmogelijk of onaantrekkelijk, maar het Plasticdieet bewijst het tegendeel. Want wees nou eerlijk, heb je echt dat plastic flesje water of dat plastic roerstaafje voor je koffie nodig?",
        start: DateTime.now(),
        end: DateTime.now(),
        category: "Sustainability",
        subCategory: "Community",
        numParticipants: 20,
      )
    ];

    _pageController.addListener(
      () => setState(() => _currentPage = _pageController.page!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor400,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "In the spotlight",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ExpandablePageView.builder(
            itemBuilder: (ctx, index) {
              final crowdAction = _pages[index];
              return CrowdActionCard(
                title: crowdAction.name,
                imagePath: crowdAction.image ?? "",
                chips: crowdAction.toChips(),
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
          const SizedBox(
            height: 5,
          ),
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
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
