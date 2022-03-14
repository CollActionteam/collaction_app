import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/crowdaction/subscription/subscription_bloc.dart';
import '../../../../../application/crowdaction/subscription_status/subscription_status_bloc.dart';
import '../../../../../domain/crowdaction/crowdaction.dart';
import '../../../shared_widgets/commitments/commitment_card_list.dart';
import '../../../shared_widgets/pill_button.dart';
import '../../../themes/constants.dart';

class ConfirmParticipation extends StatelessWidget {
  final CrowdAction crowdAction;

  const ConfirmParticipation({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        state.mapOrNull(
          (value) => {},
          subscribed: (state) {
            // Close the modal
            Navigator.of(context).pop();

            _participationSuccess(context);

            // Update Status
            context.read<SubscriptionStatusBloc>().add(
                  SubscriptionStatusEvent.checkParticipationStatus(
                    crowdAction,
                  ),
                );
          },
          subscriptionFailed: (state) {
            // TODO- Red snack bar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                content: const Text(
                  "Could not participate in crowd action",
                ),
                action: SnackBarAction(
                  onPressed: () {
                    context.read<SubscriptionBloc>().add(
                          SubscriptionEvent.participate(
                            crowdAction,
                            state.activeCommitments,
                            "",
                          ),
                        );
                  },
                  label: "Retry",
                ),
              ),
            );
          },
        );
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
              Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxHeight: 80),
                      child: Text(
                        sectionDescription(state),
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: kPrimaryColor400,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      sectionHeading(state),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: kPrimaryColor300, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CommitmentCardList(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PillButton(
                text: "Confirm",
                isLoading: state is SubscribingToCrowdAction,
                isEnabled: state.activeCommitments.isNotEmpty,
                onTap: () {
                  context.read<SubscriptionBloc>().add(
                        SubscriptionEvent.participate(
                          crowdAction,
                          state.activeCommitments,
                          "",
                        ),
                      );
                },
                margin: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton(
                  onPressed: () {
                    context.router.pop();
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

  String sectionDescription(SubscriptionState state) {
    if (state.activeCommitments.length > 1) {
      return "You’re almost there! You’ve selected the displayed commitments to stick to through this CrowdAction. By clicking “Confirm” you will officially commit to this CrowdAction.";
    } else {
      return "You’re almost there! You’ve selected the displayed commitment to stick to through this CrowdAction. By clicking “Confirm” you will officially commit to this CrowdAction.";
    }
  }

  String sectionHeading(SubscriptionState state) {
    if (state.activeCommitments.length > 1) {
      return "Your Commitments";
    } else {
      return "Your Commitment";
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
