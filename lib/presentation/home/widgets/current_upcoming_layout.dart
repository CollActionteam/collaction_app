import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/accent_chip.dart';
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
    return BlocBuilder<CrowdActionGetterBloc, CrowdActionGetterState>(
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
                          fontWeight: FontWeight.w700, fontSize: 28.0),
                    ),
                    TextButton(
                      onPressed: () => context.router.push(widget.isCurrent
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
                  ],
                ),
              ),
              state.maybeMap(
                    fetchingCrowdActions: (_) => const Center(
                        child: CircularProgressIndicator(
                      color: kAccentColor,
                    )),
                    noCrowdActions: (_) => _noCrowdAction(),
                    fetched: (fetchedData) =>
                        _fetched(fetchedData.crowdActions),
                    orElse: () {},
                  ) ??
                  const SizedBox(),
              const SizedBox(height: 20)
            ]),
      ),
    );
  }

  Widget _noCrowdAction() {
    return const Text('No crowdactions to show');
  }

  Widget _fetched(List<CrowdAction> fetchedData) {
    return Column(
      children: fetchedData
          .map(
            (e) => Container(
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
                              image: AssetImage(e.image.toString()),
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
                            const AccentChip(
                              text: "Sign up now",
                              leading: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                e.name.toString(),
                                softWrap: false,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
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
          )
          .toList(),
    );
  }
}
