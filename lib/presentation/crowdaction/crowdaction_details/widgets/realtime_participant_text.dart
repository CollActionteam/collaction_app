// TODO Untested! (Confirm if it works as intended)

import 'dart:async';

import 'package:collaction_app/application/crowdaction/subscription/subscription_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:provider/src/provider.dart';

class RealtimeParticipationText extends StatefulWidget {
  const RealtimeParticipationText({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  final CrowdAction crowdAction;

  @override
  State<RealtimeParticipationText> createState() =>
      _RealtimeParticipationTextState();
}

class _RealtimeParticipationTextState extends State<RealtimeParticipationText> {
  late StreamSubscription<SubscriptionState> subscriptionStateSubscription;
  late int participantCount;

  @override
  void dispose() {
    subscriptionStateSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    participantCount = widget.crowdAction.participantCount;
    subscriptionStateSubscription =
        context.read<SubscriptionBloc>().stream.listen((state) {
      if (state is UnsubscribingFromCrowdAction ||
          state is SubscriptionFailed) {
        setState(() {
          participantCount--;
        });
      } else if (state is SubscribingToCrowdAction ||
          state is UnsubscribingFailed) {
        setState(() {
          participantCount++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Join $participantCount participant${participantCount == 1 ? '' : 's'}",
      style: const TextStyle(color: kPrimaryColor300),
    );
  }
}
