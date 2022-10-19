import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/application/settings/build_information/build_information_bloc.dart';
import '../../../presentation/utils/launch_url.dart';
import '../../application/auth/auth_bloc.dart';
import '../../application/user/profile/profile_bloc.dart';
import '../../infrastructure/core/injection.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.gr.dart';
import '../shared_widgets/custom_app_bars/custom_appbar.dart';
import '../themes/constants.dart';
import 'widgets/build_information_tile.dart';
import 'widgets/settings_list_tile.dart';
import 'widgets/share_collaction_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(closable: true),
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
                        const ShareCollactionListTile(),
                        const SizedBox(height: 15),
                        SettingsListTile(
                          title: 'Contact us',
                          icon: CollactionIcons.message,
                          trailingIcon: CollactionIcons.arrow_right,
                          onTap: () =>
                              context.router.push(const ContactFormRoute()),
                        ),
                        const SizedBox(height: 15),
                        SettingsListTile(
                          title: 'Onboarding',
                          icon: CollactionIcons.rocket,
                          trailingIcon: CollactionIcons.arrow_right,
                          onTap: () =>
                              context.router.push(const OnboardingRoute()),
                        ),
                        const SizedBox(height: 15),
                        SettingsListTile(
                          title: 'Open source libraries',
                          icon: CollactionIcons.opensource,
                          trailingIcon: CollactionIcons.arrow_right,
                          onTap: () =>
                              context.router.push(const LicensesRoute()),
                        ),
                        const SizedBox(height: 15),
                        SettingsListTile(
                          title: 'Terms of use',
                          icon: CollactionIcons.lock,
                          trailingIcon: CollactionIcons.external_link,
                          onTap: () => launchUrl(
                            'https://www.collaction.org/terms',
                            useWebView: true,
                            context: context,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SettingsListTile(
                          title: 'Privacy policy',
                          icon: CollactionIcons.file,
                          trailingIcon: CollactionIcons.external_link,
                          onTap: () => launchUrl(
                            'https://www.collaction.org/privacy',
                            useWebView: true,
                            context: context,
                          ),
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          bloc: BlocProvider.of<ProfileBloc>(context),
                          builder: (context, ProfileState state) => state
                                      .userProfile ==
                                  null
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    SettingsListTile(
                                      title: 'Log out',
                                      icon: CollactionIcons.logout,
                                      iconColor: kErrorColor,
                                      onTap: () async {
                                        BlocProvider.of<AuthBloc>(context)
                                            .add(const AuthEvent.signedOut());
                                        await context.router.pop();
                                      },
                                    ),
                                  ],
                                ),
                        ),
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
