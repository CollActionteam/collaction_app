import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/crowdaction/commitment.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/participant.dart';
import '../../../infrastructure/core/injection.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/commitment_card.dart';
import '../../shared_widgets/participant_avatars.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';
import '../utils/crowd_action.ext.dart';

class CrowdActionDetailsPage extends StatefulWidget {
  final CrowdAction crowdAction;

  const CrowdActionDetailsPage({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  @override
  State<CrowdActionDetailsPage> createState() => _CrowdActionDetailsPageState();
}

class _CrowdActionDetailsPageState extends State<CrowdActionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // Todo remove this dummy data once pull request is approved
    final List<Commitment> commitments = [];
    for (int i = 0; i < 10; i++) {
      commitments.add(Commitment(
        id: i,
        title: 'Commitment $i',
        description: 'Some description here hi',
      ));
    }
    return Scaffold(
      floatingActionButton: BlocBuilder<SubscribeBloc, SubscribeState>(
        builder: (context, state) {
          if (state is! SubscriptionDone) {
            return PillButton(
              text: "Participate",
              onTap: () => _participate(context),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 310.0,
              pinned: true,
              backgroundColor: kAccentColor,
              automaticallyImplyLeading: false,
              title: Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => context.router.pop(),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: Colors.white,
                      onPrimary: kAccentColor,
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: kPrimaryColor200,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  /* TODO implement crowdaction sharing
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: kAccentColor,
                      onPrimary: kAccentColor,
                    ),
                    child: const Icon(CupertinoIcons.share, color: Colors.white),
                  )
                  */
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.crowdAction.image ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: kAlmostTransparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.crowdAction.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(spacing: 12.0, children: [
                      GestureDetector(
                        onTap: () {
                          // TODO - Sign up, to crowd action
                        },
                        child: const AccentChip(
                          text: "Sign up now",
                          leading: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ...widget.crowdAction.toChips()
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.router
                            .push(const CrowdActionParticipantsRoute());
                      },
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            // TODO - Add participants to crowdaction
                            SizedBox(
                              width: 100,
                              child: ParticipantAvatars(
                                participants: sampleParticipants,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Text(
                              "Join ${sampleParticipants.title(widget.crowdAction.numParticipants)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 12),
                            ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.crowdAction.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 17, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              const CommitmentsWidget(),
              const BadgesWidget(),
              const CrowdActionCreatedByWidget(),
              BlocBuilder<SubscribeBloc, SubscribeState>(
                builder: (context, state) {
                  return state.maybeMap(
                    subscriptionDone: (state) {
                      return GestureDetector(
                        onTap: () => _withdrawParticipationModal(context),
                        child: Text(
                          'Withdraw my participation',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: kSuccessColor,
                                  ),
                        ),
                      );
                    },
                    orElse: () {
                      return const Text('');
                    },
                  );
                },
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
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
        return BlocConsumer<SubscribeBloc, SubscribeState>(
          listener: (context, state) {
            state.maybeMap(
              unSubscriptionDone: (state) {
                Navigator.pop(context);
                _withdrawSuccess(context);
              },
              unSubscriptionFailed: (state) {
                // TODO- Red snack bar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: const Text(
                      "Error encountered while unsubscribing to crowdaction",
                    ),
                    action: SnackBarAction(
                      onPressed: () {
                        context.read<SubscribeBloc>().add(
                            SubscribeEvent.withDrawParticipation(
                                widget.crowdAction));
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
                    widget.crowdAction.name,
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
                    widget.crowdAction.description,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: kPrimaryColor400,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PillButton(
                    text: "Withdraw Participation",
                    isLoading: state is UnSubscribingToCrowdAction,
                    onTap: () {
                      // TODO - Withdraw Participation
                      context.read<SubscribeBloc>().add(
                          SubscribeEvent.withDrawParticipation(
                              widget.crowdAction));
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
                widget.crowdAction.name,
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

  Future<void> _participate(BuildContext context) async {
    final _user = await getIt<IAuthRepository>().getSignedInUser();

    if (mounted) {
      if (_user.isNone()) {
        _signUpModal(context);
      } else {
        _participateModal(context);
      }
    }
  }

  void _participateModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return BlocConsumer<SubscribeBloc, SubscribeState>(
            listener: (context, state) {
              state.maybeMap(
                  subscriptionDone: (state) {
                    // Close the modal
                    Navigator.of(context).pop();

                    _participationSuccess(context);
                  },
                  subscriptionFailed: (state) {
                    // TODO- Red snack bar
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: const Text(
                        "Could not participate in crowd action",
                      ),
                      action: SnackBarAction(
                        onPressed: () {
                          context.read<SubscribeBloc>().add(
                              SubscribeEvent.participate(widget.crowdAction));
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
                      widget.crowdAction.name,
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
                      widget.crowdAction.description,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: kPrimaryColor400,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PillButton(
                      text: "Confirm Participation",
                      isLoading: state is SubscribingToCrowdAction,
                      onTap: () {
                        // TODO - Confirm Participation
                        context.read<SubscribeBloc>().add(
                            SubscribeEvent.participate(widget.crowdAction));
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
        });
  }

  void _signUpModal(BuildContext context) {
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
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "You need to create an account in order to participate in a crowdaction. If you have an account already, please log in.",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: kPrimaryColor400,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PillButton(
                  text: "Create account",
                  onTap: () => _createAccount(context),
                  margin: EdgeInsets.zero,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: TextButton(
                    onPressed: () => _createAccount(context),
                    child: const Text("Log in"),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        });
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
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.crowdAction.name,
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
                "Success!",
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
                text: "Got It",
                onTap: () {
                  // TODO - Pop
                  context.router.pop();
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

  void _createAccount(BuildContext context) {
    Navigator.of(context).pop();
    context.router.push(const AuthRoute());
  }
}

class CommitmentsWidget extends StatefulWidget {
  const CommitmentsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CommitmentsWidget> createState() => _CommitmentsWidgetState();
}

class _CommitmentsWidgetState extends State<CommitmentsWidget> {
  late int _selectedCommitment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedCommitment = 0;
  }

  void handleClick(int inputCommitmentNumber) {
    setState(() {
      _selectedCommitment = _selectedCommitment == inputCommitmentNumber
          ? 0
          : inputCommitmentNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: kSecondaryColor,
        child: Column(
          children: [
            Text(
              'My commitments',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.crowdAction.name,
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
                  "Success!",
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
          ),
        ],
      ),
    );
  }

  void _createAccount(BuildContext context) {
    Navigator.of(context).pop();
    context.router.push(const AuthRoute());
  }
}
