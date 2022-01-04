import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/crowdaction/subscription_status/subscription_status_bloc.dart';
import '../../../../domain/auth/i_auth_repository.dart';
import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../domain/crowdaction/crowdaction_status.dart';
import '../../../../infrastructure/core/injection.dart';
import '../../core/collaction_icons.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/accent_chip.dart';
import '../../shared_widgets/commitments/commitment_card_list.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';
import 'widgets/confirm_participation.dart';
import 'widgets/realtime_participant_text.dart';
import 'widgets/withdraw_participation.dart';

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
  List<String> _commitments = [];
  final GlobalKey<CommitmentCardListState> _commitmentsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionStatusBloc>().add(
          SubscriptionStatusEvent.checkParticipationStatus(widget.crowdAction),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          BlocConsumer<SubscriptionStatusBloc, SubscriptionStatusState>(
        listener: (context, state) {
          if (state is SubscriptionStatus &&
              state.status is SubscribedToCrowdAction) {
            _commitments = state.status
                .maybeWhen(subscribed: dartz.id, orElse: () => <String>[]);

            _commitmentsKey.currentState?.selectCommitments(_commitments);
          }
        },
        builder: (context, state) {
          if (state is SubscriptionStatus &&
              state.status is SubscribedToCrowdAction) {
            return Container();
          } else {
            return PillButton(
              text: "Participate",
              isLoading: state is CheckingSubscriptionStatus,
              isEnabled: _commitments.isNotEmpty,
              onTap: () => _participate(context),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 310.0,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  SizedBox(
                    width: 39,
                    height: 39,
                    child: Material(
                      type: MaterialType.button,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => context.router.pop(),
                        child: const Icon(
                          CollactionIcons.left,
                          color: kPrimaryColor400,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.crowdAction.images.banner,
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
                width: double.infinity,
                color: kAlmostTransparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.crowdAction.title,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      spacing: 12.0,
                      children: [
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
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// TODO: Implement properly after MVP
                    RealtimeParticipationText(
                      crowdAction: widget.crowdAction,
                    ),
                    const SizedBox(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     context.router
                    //         .push(const CrowdActionParticipantsRoute());
                    //   },
                    //   child: SizedBox(
                    //     height: 40,
                    //     child: Row(
                    //       children: [
                    //         // TODO - Add participants to crowdaction
                    //         SizedBox(
                    //           width: widget.crowdAction.avatarWidth(),
                    //           child: ParticipantAvatars(
                    //             participants:
                    //                 widget.crowdAction.topParticipants,
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           width: 20,
                    //         ),
                    //         Expanded(
                    //           child: Text(
                    //             "Join ${widget.crowdAction.topParticipants.title(widget.crowdAction.participantCount)}",
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .caption
                    //                 ?.copyWith(
                    //                   fontSize: 12,
                    //                   color: kPrimaryColor300,
                    //                 ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Text(
                      widget.crowdAction.description,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 8.0),
                child: Column(
                  children: [
                    Text(
                      'My commitments',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        'Your challenge, your rules.\nChoose which commitment you want to make this month.',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: kPrimaryColor300,
                              fontWeight: FontWeight.w400,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 20),
                child: BlocBuilder<SubscriptionStatusBloc,
                    SubscriptionStatusState>(
                  builder: (context, state) {
                    return CommitmentCardList(
                      readOnly: state is SubscriptionStatus &&
                          state.status is SubscribedToCrowdAction,
                      key: _commitmentsKey,
                      active: _commitments,
                      commitments: widget.crowdAction.commitmentOptions,
                      onSelected: (List<String> selectedIds) {
                        setState(() => _commitments = selectedIds);
                      },
                    );
                  },
                ),
              ),

              /// TODO: Implement after MVP
              // const BadgesWidget(),
              // CrowdActionCreatedByWidget(
              //   crowdAction: widget.crowdAction,
              // ),
              WithdrawParticipation(
                crowdAction: widget.crowdAction,
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
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
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return ConfirmParticipation(
          commitments: _commitments,
          crowdAction: widget.crowdAction,
          onSelect: (List<String> selectedIds) {
            setState(() {
              _commitments = selectedIds;
            });
          },
        );
      },
    );
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
                "Register",
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
      },
    );
  }

  void _createAccount(BuildContext context) {
    Navigator.of(context).pop();
    context.router.push(const AuthRoute());
  }
}
