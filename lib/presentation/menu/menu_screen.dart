import 'package:auto_route/auto_route.dart';
import 'widgets/build_information_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';
import '../../application/settings/build_information/build_information_bloc.dart';
import '../../application/user/profile/profile_bloc.dart';
import '../../infrastructure/core/injection.dart';
import '../routes/app_routes.gr.dart';
import '../utils/launch_url.dart';
import 'widgets/avatar_info.dart';
import 'widgets/header_bar.dart';
import 'widgets/legal_info_policy_widget.dart';
import 'package:flutter/material.dart';
import '../themes/constants.dart';
import '../core/collaction_icons.dart';
import 'widgets/user_info_and_avatar.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider<ProfileBloc>.value(
            value: BlocProvider.of<ProfileBloc>(context),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 22.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderBar(),
                        UserInfoAndAvatar(
                          pictureUrl: state.userProfile?.profile.avatar,
                          name: state.userProfile?.profile.firstName,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        GestureDetector(
                          onTap: () async {
                            BlocProvider.of<AuthBloc>(context)
                                .add(const AuthEvent.signedOut());
                            BlocProvider.of<ProfileBloc>(context)
                                .add(GetUserProfile());
                            await context.router.pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: kErrorColor,
                              ),
                              SizedBox(
                                width: 2.5,
                              ),
                              Text(
                                "Log out",
                                style: TextStyle(
                                  color: kErrorColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Subtitle(
                    subTitle: "Account",
                    paddingTop: 38.5,
                    paddingBottom: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.25),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: kPrimaryColor300,
                            size: 19.5,
                          ),
                          SizedBox(
                            width: 12.25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Account Information",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor300),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 306,
                                child: Text(
                                  "View and update your account  and contact information that is associated with your CollAction account.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: kPrimaryColor300,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Subtitle(
                      subTitle: "Feedback", paddingTop: 30, paddingBottom: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 22.5,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CollactionIcons.message,
                            color: kPrimaryColor300,
                            size: 15,
                          ),
                          SizedBox(
                            width: 16.25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contact us",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor300),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 305,
                                child: Text(
                                  "Have a general enquiry, business proposal, or simply want us to send your feedback or regards? Get in contact with us through our form.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: kPrimaryColor300,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Subtitle(
                      subTitle: "Legal information and policies",
                      paddingBottom: 24,
                      paddingTop: 30),
                  LegalInfoAndPoliciesWidget(
                      onTap: () async {
                        launchUrl(
                          'https://www.collaction.org/privacy',
                          useWebView: true,
                          context: context,
                        );
                      },
                      iconWidget: CollactionIcons.lock,
                      label: "Privacy Policy"),
                  LegalInfoAndPoliciesWidget(
                      onTap: () => launchUrl(
                            'https://www.collaction.org/terms',
                            useWebView: true,
                            context: context,
                          ),
                      iconWidget: CollactionIcons.file,
                      label: "Terms & conditions"),
                  LegalInfoAndPoliciesWidget(
                      onTap: () => context.router.push(const LicensesRoute()),
                      iconWidget: CollactionIcons.opensource,
                      label: "Open-source libraries"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<BuildInformationBloc, BuildInformationState>(
                        bloc: getIt<BuildInformationBloc>()
                          ..add(const BuildInformationEvent.fetch()),
                        builder: (context, state) {
                          return state.when(
                            loading: () => const SizedBox(),
                            fetched: (buildInfo) =>
                                BuildInformationTile(information: buildInfo),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  final double paddingTop;

  final double paddingBottom;

  final String subTitle;

  const Subtitle(
      {Key? key,
      required this.paddingTop,
      required this.paddingBottom,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 20, top: paddingTop, bottom: paddingBottom),
      child: Text(
        subTitle,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: kPrimaryColor300,
        ),
      ),
    );
  }
}
