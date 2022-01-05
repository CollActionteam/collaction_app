import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/auth/auth_bloc.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.gr.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../themes/constants.dart';

const shareText =
    "Check out CollAction at https://play.google.com/store/apps/details?id=org.collaction.collaction_app for Android and https://apps.apple.com/app/id1597643827 for iOS. Let's solve all collective action problems in the world.";
const shareEmailSubject = "Join me on CollAction";

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ossLicenses = ListTile(
      // TODO change to "Open source libraries" and use https://pub.dev/packages/flutter_oss_licenses
      onTap: () => launch('https://github.com/CollActionteam/collaction_app'),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      tileColor: kAlmostTransparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      leading: const CircleAvatar(
        radius: 32.5,
        backgroundColor: kSecondaryColor,
        child: Icon(
          CollactionIcons.opensource,
          color: kPrimaryColor300,
        ),
      ),
      title: const Text(
        'Open source',
      ),
      trailing: const Icon(CollactionIcons.arrow_right),
    );

    final logoutButton = ListTile(
      onTap: () async {
        // TODO: Fix Profile Page not updating + pop settings page
        BlocProvider.of<AuthBloc>(context).add(const AuthEvent.signedOut());
        await context.router.pop();
      },
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      tileColor: kAlmostTransparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      leading: const CircleAvatar(
        radius: 32.5,
        backgroundColor: kSecondaryColor,
        child: Icon(
          CollactionIcons.share,
          color: kErrorColor,
        ),
      ),
      title: const Text(
        'Log out',
      ),
    );

    return Scaffold(
      appBar: CustomAppBar(context, closable: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: Implement edit user name
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 16.0),
                    //   child: Text(
                    //     'Account',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w700,
                    //       fontSize: 11,
                    //       color: kPrimaryColor300,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 16.0),
                    //   child: Text(
                    //     'Other',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w700,
                    //       fontSize: 11,
                    //       color: kPrimaryColor300,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    Column(
                      children: [
                        ListTile(
                          onTap: () => Share.share(
                            shareText,
                            subject: shareEmailSubject,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          tileColor: kAlmostTransparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          leading: const CircleAvatar(
                            radius: 32.5,
                            backgroundColor: kSecondaryColor,
                            child: Icon(
                              CollactionIcons.share,
                              color: kPrimaryColor300,
                            ),
                          ),
                          title: const Text(
                            'Share CollAction',
                          ),
                          trailing: const Icon(CollactionIcons.arrow_right),
                        ),
                        const SizedBox(height: 15),
                        ListTile(
                          onTap: () => context.router.push(const ContactFormRoute()),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          tileColor: kAlmostTransparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          leading: const CircleAvatar(
                            radius: 32.5,
                            backgroundColor: kSecondaryColor,
                            child: Icon(
                              CollactionIcons.message,
                              color: kPrimaryColor300,
                            ),
                          ),
                          title: const Text(
                            'Contact us',
                          ),
                          trailing: const Icon(CollactionIcons.arrow_right),
                        ),
                        const SizedBox(height: 15),
                        ListTile(
                          onTap: () =>
                              launch('https://www.collaction.org/terms'),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          tileColor: kAlmostTransparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          leading: const CircleAvatar(
                            radius: 32.5,
                            backgroundColor: kSecondaryColor,
                            child: Icon(
                              CollactionIcons.file,
                              color: kPrimaryColor300,
                            ),
                          ),
                          title: const Text(
                            'Terms of use',
                          ),
                          trailing: const Icon(CollactionIcons.arrow_right),
                        ),
                        const SizedBox(height: 15),
                        ListTile(
                          onTap: () =>
                              launch('https://www.collaction.org/privacy'),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          tileColor: kAlmostTransparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          leading: const CircleAvatar(
                            radius: 32.5,
                            backgroundColor: kSecondaryColor,
                            child: Icon(
                              CollactionIcons.lock,
                              color: kPrimaryColor300,
                            ),
                          ),
                          title: const Text(
                            'Privacy policy',
                          ),
                          trailing: const Icon(CollactionIcons.arrow_right),
                        ),
                        const SizedBox(height: 15),
                        ossLicenses,
                        BlocBuilder(
                          bloc: getIt<ProfileBloc>()..add(GetUserProfile()),
                          builder: (context, ProfileState state) =>
                              state.userProfile == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        logoutButton,
                                      ],
                                    ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
