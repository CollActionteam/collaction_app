import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../infrastructure/core/injection.dart';
import '../shared_widgets/centered_loading_indicator.dart';
import '../shared_widgets/custom_app_bars/clean_app_bar.dart';
import '../shared_widgets/return_elevated_button.dart';
import 'widgets/micro_crowdaction_card.dart';

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
        appBar: CleanAppBar(
          title: 'Browse Crowdactions',
          leading: returnElevatedButton(context),
        ),
        body: BlocBuilder<CrowdActionGetterBloc, CrowdActionGetterState>(
          builder: (context, state) => state.when(
            initial: () => const CenteredLoadingIndicator(),
            fetchingCrowdActions: () => const CenteredLoadingIndicator(),
            noCrowdActions: () => Column(
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
                itemCount: crowdActions.length,
                itemBuilder: (context, index) =>
                    MicroCrowdActionCard(crowdActions[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
