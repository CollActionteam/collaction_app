import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/crowdaction/subscription/subscription_bloc.dart';
import '../../../../../application/crowdaction/subscription_status/subscription_status_bloc.dart';
import '../../../../../domain/crowdaction/crowdaction.dart';
import '../../../../../domain/crowdaction/crowdaction_status.dart';
import '../../../../shared_widgets/pill_button.dart';
import '../../../../themes/constants.dart';

class WithdrawParticipation extends StatelessWidget {
  final CrowdAction crowdAction;

  const WithdrawParticipation({Key? key, required this.crowdAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionStatusBloc, SubscriptionStatusState>(
      builder: (context, state) {
        return state.maybeMap(
          subscriptionStatus: (state) {
            if (state.status is SubscribedToCrowdAction) {
              return GestureDetector(
                onTap: () => _withdrawParticipationModal(context),
                child: Text(
                  'Cancel my participation',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: kSuccessColor,
                      ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
          orElse: () {
            return const SizedBox();
          },
        );
      },
    );
  }

  void _withdrawParticipationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return BlocConsumer<SubscriptionBloc, SubscriptionState>(
          listener: (context, state) {
            state.maybeMap(
              unsubscribed: (state) {
                Navigator.pop(context);
                _withdrawSuccess(context);

                // Update Status
                context.read<SubscriptionStatusBloc>().add(
                    SubscriptionStatusEvent.checkParticipationStatus(
                        crowdAction));
              },
              unsubscribingFailed: (state) {
                // TODO- Red snack bar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                    content: const Text(
                      "Error encountered while unsubscribing to crowdaction",
                    ),
                    action: SnackBarAction(
                      onPressed: () {
                        context.read<SubscriptionBloc>().add(
                            SubscriptionEvent.withdrawParticipation(
                                crowdAction));
                      },
                      label: "Retry",
                    ),
                  ),
                );
              },
              orElse: () {},
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
                    "We’d love to keep you",
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
                    "You are about to cancel your participation. You are free to sign up for this CrowdAction again any time before it starts.",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: kPrimaryColor400,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PillButton(
                    text: "Cancel my participation",
                    isLoading: state is UnsubscribingFromCrowdAction,
                    onTap: () {
                      // TODO - Withdraw Participation
                      context.read<SubscriptionBloc>().add(
                            SubscriptionEvent.withdrawParticipation(
                                crowdAction),
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
      },
    );
  }

  void _withdrawSuccess(BuildContext context) {
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
                crowdAction.title,
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
                "We are sad to see you withdraw!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
              ),

              const SizedBox(
                height: 20,
              ),
              PillButton(
                text: "Got It",
                onTap: () {
                  Navigator.pop(context);
                },
                margin: EdgeInsets.zero,
              ),
              const SizedBox(height: 20),
              //TODO - Add message to change commitments const Divider(),
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
