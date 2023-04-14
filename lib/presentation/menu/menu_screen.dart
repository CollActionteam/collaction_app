import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../application/auth/auth_bloc.dart';
import '../../application/user/profile/profile_bloc.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.gr.dart';
import '../themes/constants.dart';
import '../utils/launch_url.dart';
import 'widgets/build_information_tile.dart';
import 'widgets/ca_menu_item.dart';
import 'widgets/header_bar.dart';
import 'widgets/menu_category.dart';
import 'widgets/user_info_and_avatar.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // TODO: Have it's own BLoC
          child: BlocProvider<ProfileBloc>.value(
            value: BlocProvider.of<ProfileBloc>(context),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.userProfile == null) {
                  // TODO: Loading state
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
padding: const EdgeInsets.fromLTRB(20, 10, 20, 6),```
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Menu",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: kPrimaryColor400,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Search bar functionality
            },
            icon: Icon(
              Ionicons.search,
              color: kPrimaryColor600,
              size: 26,
            ),
          ),
        ],
      ),
                          const SizedBox(height: 30),
                          UserInfoAndAvatar(
                            avatar: state.userProfile!.profile.avatar,
                            fullName: state.userProfile!.profile.fullName,
                          ),
                          SizedBox(height: 16),
                          // TODO: Extract Logout button to widget
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
                                Icon(Icons.logout,
                                    color: kErrorColor, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  "Log out",
                                  style: TextStyle(
                                    color: kErrorColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    MenuCategory(
                      label: 'Account',
                      items: [
                        CAMenuItem(
                          icon: Icon(
                            Ionicons.person_circle_outline,
                            color: kPrimaryColor300,
                          ),
                          label: "Account Information",
                          description:
                              "View and update your account and contact information that is associated with your CollAction account.",
                          onTap: () {
                            // TODO: Open Account Information Page
                          },
                        ),
                      ],
                    ),
                    MenuCategory(
                      label: 'Feedback',
                      items: [
                        CAMenuItem(
                          icon: Icon(
                            CollactionIcons.message,
                            size: 20,
                            color: kPrimaryColor300,
                          ),
                          label: "Contact us",
                          description:
                              "Have a general enquiry, business proposal, or simply want us to send your feedback or regards? Get in contact with us through our form.",
                          onTap: () {
                            // TODO: Open Contact Us Full-screen Dialog
                          },
                        ),
                      ],
                    ),
                    MenuCategory(
                      label: 'Legal information and policies',
                      items: [
                        CAMenuItem(
                          icon: Icon(
                            CollactionIcons.lock,
                            size: 20,
                            color: kPrimaryColor300,
                          ),
                          label: "Privacy Policy",
                          onTap: () => launchUrl(
                            'https://www.collaction.org/privacy',
                            useWebView: true,
                            context: context,
                          ),
                        ),
                        CAMenuItem(
                          icon: Icon(
                            CollactionIcons.file,
                            size: 20,
                            color: kPrimaryColor300,
                          ),
                          label: "Terms & conditions",
                          onTap: () => launchUrl(
                            'https://www.collaction.org/terms',
                            useWebView: true,
                            context: context,
                          ),
                        ),
                        CAMenuItem(
                          icon: Icon(
                            CollactionIcons.opensource,
                            size: 20,
                            color: kPrimaryColor300,
                          ),
                          label: "Open-source libraries",
                          onTap: () =>
                              context.router.push(const LicensesRoute()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(child: BuildInformationTile()),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
