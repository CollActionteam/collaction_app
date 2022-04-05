import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../shared_widgets/centered_loading_indicator.dart';
import '../../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../../shared_widgets/micro_crowdaction_card.dart';
import '../../themes/constants.dart';

/// Route for the user to browse available Collactions.
class CrowdActionBrowsePage extends StatelessWidget {
  const CrowdActionBrowsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CrowdActionGetterBloc>(
      create: (context) => getIt<CrowdActionGetterBloc>()
        ..add(const CrowdActionGetterEvent.getMore(null)),
      child: const Scaffold(
        appBar: CustomAppBar(title: 'Browse CrowdActions'),
        body: _CrowdActionBrowseView(),
      ),
    );
  }
}

class _CrowdActionBrowseView extends StatelessWidget {
  const _CrowdActionBrowseView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => Future.delayed(
        const Duration(seconds: 1),
        () => context.read<CrowdActionGetterBloc>().add(
              const CrowdActionGetterEvent.getMore(null),
            ),
      ),
      color: kAccentColor,
      child: BlocBuilder<CrowdActionGetterBloc, CrowdActionGetterState>(
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
    );
  }
}
