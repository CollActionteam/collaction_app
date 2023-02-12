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
import 'widgets/legal_info_policy_widget.dart';
import 'package:flutter/material.dart';
import '../themes/constants.dart';
import '../core/collaction_icons.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuPage> {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Menu",
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: kPrimaryColor600,
                                size: 21.08,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 85,
                          decoration: avatarInfoDecorationBox,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 10,
                              right: 25.5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AvatarAndInfo(
                                  pictureUrl: state.userProfile?.profile.avatar,
                                  name: state.userProfile?.profile.firstName,
                                ),
                                GestureDetector(
                                  onTap: () {
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.settings,
                                        color: kPrimaryColor600,
                                        size: 21,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                  fontFamily: "Rubik",
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
                  _buildSubTitle(
                      subTitle: "Account", paddingTop: 38.5, paddingBottom: 20),
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
                  _buildSubTitle(
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
                  _buildSubTitle(
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
                      BlocBuilder<BuildInformationBloc,
                          BuildInformationState>(
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

  Widget _buildSubTitle(
      {required String subTitle,
      double paddingTop = 0.0,
      double paddingBottom = 0.0}) {
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
