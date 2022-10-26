import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/application/participation/participation_bloc.dart';
import 'package:collaction_app/application/user/profile_tab/profile_tab_bloc.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/crowdaction_chips.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/crowdaction_details_banner.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/crowdaction_title.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/participants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../infrastructure/core/injection.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/commitments/commitment_card_list.dart';
import '../../shared_widgets/expandable_text.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';
import 'widgets/confirm_participation.dart';
import 'widgets/withdraw_participation.dart';

class CrowdActionDetailsPage extends StatefulWidget {
  final CrowdAction? crowdAction;
  final String? crowdActionId;

  const CrowdActionDetailsPage({
    super.key,
    this.crowdAction,
    this.crowdActionId,
  }) : assert(crowdAction != null || crowdActionId != null);

  @override
  State<CrowdActionDetailsPage> createState() => CrowdActionDetailsPageState();
}

class CrowdActionDetailsPageState extends State<CrowdActionDetailsPage> {
  final List<CommitmentOption> selectedCommitments = [];
  CrowdAction? crowdAction;
  late final ParticipationBloc participationBloc;
  late Function(BuildContext) participate;

  late final String id;

  @override
  void initState() {
    super.initState();
    participationBloc = getIt<ParticipationBloc>();
    participate = _signUpModal;
    id = widget.crowdActionId ?? widget.crowdAction!.id;
    crowdAction = widget.crowdAction;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CrowdActionDetailsBloc>(
          create: (context) => getIt<CrowdActionDetailsBloc>()
            ..add(
              CrowdActionDetailsEvent.fetchCrowdAction(
                id: widget.crowdActionId ?? widget.crowdAction!.id,
              ),
            ),
        ),
        BlocProvider<ProfileTabBloc>.value(
          value: BlocProvider.of<ProfileTabBloc>(context),
        ),
        BlocProvider<ParticipationBloc>(
          create: (context) => participationBloc
            ..add(
              ParticipationEvent.getParticipation(crowdActionId: id),
            ),
        ),
        BlocProvider<AuthBloc>(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ParticipationBloc, ParticipationState>(
            listener: (context, state) {
              state.whenOrNull(
                participating: (p) {
                  setState(() {
                    selectedCommitments.clear();
                    for (final id in p.commitmentOptions) {
                      selectedCommitments.add(
                        crowdAction!.commitmentOptions
                            .firstWhere((c) => c.id == id),
                      );
                    }
                  });
                },
              );

              BlocProvider.of<CrowdActionDetailsBloc>(context).add(
                CrowdActionDetailsEvent.fetchCrowdAction(
                  id: id,
                ),
              );

              BlocProvider.of<ProfileTabBloc>(context).add(
                FetchProfileTabInfo(),
              );
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                authenticated: (_) => participate = _participateModal,
                orElse: () => participate = _signUpModal,
              );
            },
          ),
          BlocListener<CrowdActionDetailsBloc, CrowdActionDetailsState>(
            listener: (context, state) {
              state.maybeMap(
                loadSuccess: (state) {
                  crowdAction = state.crowdAction;
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: BlocBuilder<CrowdActionDetailsBloc, CrowdActionDetailsState>(
          builder: (context, state) {
            if (crowdAction == null && widget.crowdAction != null) {
              crowdAction = widget.crowdAction;
            }

            return BlocBuilder<ParticipationBloc, ParticipationState>(
              builder: (context, state) {
                return Scaffold(
                  floatingActionButton: state.when(
                    loading: () => const PillButton(
                      text: "Participate",
                      isEnabled: false,
                      isLoading: true,
                    ),
                    notParticipating: () => PillButton(
                      text: "Participate",
                      onTap: () => participate.call(context),
                    ),
                    participating: (_) => const SizedBox.shrink(),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        CrowdActionDetailsBanner(
                          crowdAction: crowdAction,
                        ),
                      ];
                    },
                    body: RefreshIndicator(
                      onRefresh: () async =>
                          BlocProvider.of<CrowdActionDetailsBloc>(context).add(
                        CrowdActionDetailsEvent.fetchCrowdAction(id: id),
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
                                  CrowdActionTitle(title: crowdAction?.title),
                                  const SizedBox(height: 20),
                                  CrowdActionChips(
                                    isOpen: crowdAction?.isOpen ?? false,
                                    category: crowdAction?.category,
                                    subCategory: crowdAction?.subcategory,
                                  ),
                                  const SizedBox(height: 20),
                                  Participants(
                                    crowdAction: crowdAction,
                                  ),
                                  const SizedBox(height: 20),
                                  CrowdActionDescription(
                                    crowdAction: crowdAction,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 8.0,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'My commitments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 28,
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      10,
                                      0,
                                      0,
                                    ),
                                    child: Text(
                                      'Your challenge, your rules.\nChoose which commitment(s) you want to make for this CrowdAction.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: kPrimaryColor300,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommitmentCardList(
                              isEnded: crowdAction?.isClosed ?? true,
                              commitmentOptions: crowdAction?.commitmentOptions,
                              selectedCommitments: selectedCommitments,
                            ),

                            /// TODO: Implement after MVP
                            // const BadgesWidget(),
                            // CrowdActionCreatedByWidget(
                            //   crowdAction: widget.crowdAction,
                            // ),
                            if (crowdAction != null &&
                                crowdAction!.status != Status.ended) ...[
                              BlocProvider.value(
                                value: participationBloc,
                                child: WithdrawParticipation(
                                  participationBloc: participationBloc,
                                  crowdAction: crowdAction!,
                                  isParticipating: state.whenOrNull(
                                        participating: (_) => true,
                                      ) ??
                                      false,
                                ),
                              ),
                              const SizedBox(height: 70),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
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
        return BlocProvider.value(
          value: participationBloc,
          child: ConfirmParticipation(
            crowdAction: crowdAction!,
            selectedCommitments: selectedCommitments,
          ),
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
                text: "Sign in",
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

class CrowdActionDescription extends StatelessWidget {
  const CrowdActionDescription({
    super.key,
    required this.crowdAction,
  });

  final CrowdAction? crowdAction;

  @override
  Widget build(BuildContext context) {
    if (crowdAction == null) {
      return Shimmer.fromColors(
        baseColor: kPrimaryColor100,
        highlightColor: kPrimaryColor200,
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor100,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    return ExpandableText(
      crowdAction!.description,
      trimLines: 5,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            height: 1.5,
          ),
    );
  }
}
