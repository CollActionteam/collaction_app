import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/crowdaction/subscription/subscription_bloc.dart';
import '../../../../../application/crowdaction/subscription_status/subscription_status_bloc.dart';
import '../../../../../domain/crowdaction/crowdaction.dart';
import '../../../../shared_widgets/commitments/commitment_card_list.dart';
import '../../../../shared_widgets/pill_button.dart';
import '../../../../themes/constants.dart';

class ConfirmParticipation extends StatefulWidget {
  final CrowdAction crowdAction;
  final List<String> commitments;
  final Function(List<String>) onSelect;

  const ConfirmParticipation({
    Key? key,
    required this.crowdAction,
    required this.commitments,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<ConfirmParticipation> createState() => _ConfirmParticipationState();
}

class _ConfirmParticipationState extends State<ConfirmParticipation> {
  late List<String> _commitments;

  @override
  void initState() {
    _commitments = List<String>.from(widget.commitments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        state.maybeMap(
            subscribed: (state) {
              // Close the modal
              Navigator.of(context).pop();

              _participationSuccess(context);

              // Update Status
              context.read<SubscriptionStatusBloc>().add(
                  SubscriptionStatusEvent.checkParticipationStatus(
                      widget.crowdAction));
            },
            subscriptionFailed: (state) {
              // TODO- Red snack bar
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                content: const Text(
                  "Could not participate in crowd action",
                ),
                action: SnackBarAction(
                  onPressed: () {
                    context.read<SubscriptionBloc>().add(
                        SubscriptionEvent.participate(
                            widget.crowdAction, _commitments, ""));
                  },
                  label: "Retry",
                ),
              ));
            },
            orElse: () {});
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 60.0,
                height: 3.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kSecondaryTransparent,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Participate",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                //! Commitment(s) based on selected commitments
                sectionDescription(),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: kPrimaryColor400,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Your Commitment",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: kPrimaryColor300, fontSize: 10),
              ),
              const SizedBox(
                height: 20,
              ),
              CommitmentCardList(
                active: _commitments,
                commitments: widget.crowdAction.commitmentOptions
                    .where((commitment) => _commitments.contains(commitment.id))
                    .toList(),
                onSelected: (selectedIds) {
                  setState(() {
                    _commitments = selectedIds;
                  });
                  widget.onSelect(selectedIds);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              PillButton(
                text: "Confirm",
                isLoading: state is SubscribingToCrowdAction,
                isEnabled: _commitments.isNotEmpty,
                onTap: () {
                  // TODO - Confirm Participation
                  context.read<SubscriptionBloc>().add(
                      SubscriptionEvent.participate(
                          widget.crowdAction, _commitments, ""));
                },
                margin: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }

  String sectionDescription() {
    if (_commitments.length > 1) {
      return "You’re almost there! You’ve selected the displayed commitments to stick to through this CrowdAction. By clicking “Confirm” you will officially commit to this CrowdAction.";
    } else {
      return "You’re almost there! You’ve selected the displayed commitment to stick to through this CrowdAction. By clicking “Confirm” you will officially commit to this CrowdAction.";
    }
  }

  void _participationSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 60.0,
                height: 3.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kSecondaryTransparent,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Participate",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                "All set!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "You have successfully registered for this CrowdAction",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: kPrimaryColor400,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              PillButton(
                text: "Got it",
                onTap: () {
                  // TODO - Pop
                  context.router.pop();
                },
                margin: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              // TODO - Add message to change commitments const Divider(),
              // TODO - Change button: "Change" -> "Change commitment"
              Container(
                padding: const EdgeInsets.all(20.0),
                constraints: const BoxConstraints(maxWidth: 250),
                child: Text(
                  "You can change your commitment until the CrowdAction starts",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: kPrimaryColor200,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
              // const SizedBox(
              //   height: 15,
              // ),
            ],
          ),
        );
      },
    );
  }
}
