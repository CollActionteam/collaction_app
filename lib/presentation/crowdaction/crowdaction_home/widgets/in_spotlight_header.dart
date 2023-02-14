import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../../../core/core.dart';
import '../../../shared_widgets/content_placeholder.dart';
import 'spotlight_crowdactions/spotlight_crowdactions.dart';

class InSpotLightHeader extends StatefulWidget {
  const InSpotLightHeader({
    super.key,
  });

  @override
  State<InSpotLightHeader> createState() => _InSpotLightHeaderState();
}

class _InSpotLightHeaderState extends State<InSpotLightHeader> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<SpotlightBloc>(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
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
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.primaryColor400,
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
                        return const SpotlightEmptyHeader();
                      },
                      spotLightCrowdActionsError: (_) {
                        return ContentPlaceholder(
                          textColor: context.onBackground,
                        );
                      },
                      spotLightCrowdActions: (pages) {
                        return SpotlightCrowdActions(pages: pages);
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
      ),
    );
  }

  String sectionHeadingText() {
    final month = DateFormat.MMMM().format(DateTime.now());
    return "$month's CrowdActions";
  }
}
