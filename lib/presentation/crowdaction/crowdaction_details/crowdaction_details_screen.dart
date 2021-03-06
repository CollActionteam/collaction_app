import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/crowdaction/spotlight/spotlight_bloc.dart';
import '../../../../application/crowdaction/subscription_status/subscription_status_bloc.dart';
import '../../../../domain/auth/i_auth_repository.dart';
import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../infrastructure/core/injection.dart';
import '../../../application/crowdaction/subscription/subscription_bloc.dart';
import '../../core/collaction_icons.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/accent_chip.dart';
import '../../shared_widgets/commitments/commitment_card_list.dart';
import '../../shared_widgets/custom_fab.dart';
import '../../shared_widgets/expandable_text.dart';
import '../../shared_widgets/image_skeleton_loader.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';
import 'widgets/confirm_participation.dart';
import 'widgets/participation_count_text.dart';
import 'widgets/withdraw_participation.dart';

class CrowdActionDetailsPage extends StatelessWidget {
  final CrowdAction crowdAction;

  const CrowdActionDetailsPage({
    Key? key,
    required this.crowdAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SpotlightBloc>(),
      child: _CrowdActionDetailsView(
        crowdAction: crowdAction,
      ),
    );
  }
}

class _CrowdActionDetailsView extends StatefulWidget {
  const _CrowdActionDetailsView({Key? key, required this.crowdAction})
      : super(key: key);

  final CrowdAction crowdAction;

  @override
  State<_CrowdActionDetailsView> createState() =>
      _CrowdActionDetailsViewState();
}

class _CrowdActionDetailsViewState extends State<_CrowdActionDetailsView> {
  final _headerHeight = 310.0;

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionStatusBloc>().add(
          SubscriptionStatusEvent.checkParticipationStatus(widget.crowdAction),
        );
    context
        .read<SubscriptionBloc>()
        .add(SubscriptionEvent.setCommitments(widget.crowdAction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _participateButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: _headerHeight,
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
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: widget.crowdAction.images.banner,
                        placeholder: (context, url) => ImageSkeletonLoader(
                          height: _headerHeight,
                        ),
                        errorWidget: (context, url, error) =>
                            ImageSkeletonLoader(
                          height: _headerHeight,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (widget.crowdAction.hasPassword) ...[
                      const Positioned(
                        bottom: 10,
                        right: 10,
                        child: CustomFAB(
                          heroTag: 'locked',
                          isMini: true,
                          color: kSecondaryColor,
                          child: Icon(
                            CollactionIcons.lock,
                            color: kPrimaryColor300,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async => context.read<SpotlightBloc>().add(
                const SpotlightEvent.getSpotLightCrowdActions(),
              ),
          color: kAccentColor,
          child: SingleChildScrollView(
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
                          AccentChip(
                            text: widget.crowdAction.isOpen ? "Open" : "Closed",
                            color: widget.crowdAction.isOpen
                                ? kAccentColor
                                : kPrimaryColor200,
                          ),
                          ...widget.crowdAction.toChips()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      /// TODO: Implement properly after MVP
                      ParticipationCountText(
                        crowdAction: widget.crowdAction,
                      ),
                      const SizedBox(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      ExpandableText(
                        widget.crowdAction.description,
                        trimLines: 5,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                              height: 1.5,
                            ),
                      ),
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

                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 20),
                  child: CommitmentCardList(),
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
      ),
    );
  }

  Widget? _participateButton() {
    return widget.crowdAction.isOpen
        ? BlocConsumer<SubscriptionStatusBloc, SubscriptionStatusState>(
            listener: (context, state) {
              context.read<SubscriptionBloc>()
                ..add(
                  SubscriptionEvent.setActiveCommitments(
                    state.isSubscribed ? state.commitments : [],
                  ),
                )
                ..add(
                  SubscriptionEvent.setDeactivatedState(
                    isDeactivated: state.isSubscribed,
                  ),
                );
            },
            builder: (context, state) {
              if (state.isSubscribed) {
                return const SizedBox();
              } else {
                return BlocBuilder<SubscriptionBloc, SubscriptionState>(
                  builder: (context, subscriptionState) {
                    return PillButton(
                      text: "Participate",
                      isLoading: state is CheckingSubscriptionStatus,
                      isEnabled: subscriptionState.activeCommitments.isNotEmpty,
                      onTap: () => _participate(context),
                    );
                  },
                );
              }
            },
          )
        : null;
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
          crowdAction: widget.crowdAction,
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
                height: 5.0,
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
