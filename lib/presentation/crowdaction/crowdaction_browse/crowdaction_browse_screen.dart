import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../shared_widgets/centered_loading_indicator.dart';
import '../../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../../shared_widgets/micro_crowdaction_card.dart';

/// Route for the user to browse available Collactions.
class CrowdActionBrowsePage extends StatefulWidget {
  const CrowdActionBrowsePage({Key? key}) : super(key: key);

  @override
  _CrowdActionBrowsePageState createState() => _CrowdActionBrowsePageState();
}

class _CrowdActionBrowsePageState extends State<CrowdActionBrowsePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrowdActionGetterBloc>(
      create: (context) => getIt<CrowdActionGetterBloc>()
        ..add(const CrowdActionGetterEvent.getMore(null)),
      child: Scaffold(
        appBar: CustomAppBar(context, title: 'Browse CrowdActions'),
        body: BlocBuilder<CrowdActionGetterBloc, CrowdActionGetterState>(
          builder: (context, state) => state.maybeMap(
            initial: (_) => const CenteredLoadingIndicator(),
            fetchingCrowdActions: (_) => const CenteredLoadingIndicator(),
            noCrowdActions: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    'No CrowdActions at the moment...',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            fetched: (crowdActions) {
              return ListView.builder(
                itemCount: crowdActions.crowdActions.length,
                itemBuilder: (context, index) =>
                    MicroCrowdActionCard(crowdActions.crowdActions[index]),
              );
            },
            orElse: () => const SizedBox(),
          ),
        ),
      ),
    );
  }
}
