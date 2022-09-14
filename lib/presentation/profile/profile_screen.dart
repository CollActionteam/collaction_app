import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:share_plus/share_plus.dart';

import '../../application/user/profile/profile_bloc.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.gr.dart';
import '../shared_widgets/photo_selector.dart';
import '../shared_widgets/pill_button.dart';
import '../themes/constants.dart';
import 'widget/profile_picture.dart';
import 'widget/profile_tab.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File? _image;

  Future<void> share() async {
    await Share.share(
      'Become part of the CollAction crowd. Join now via ${Platform.isAndroid ? "https://play.google.com/store/apps/details?id=org.collaction.collaction_app" : "https://apps.apple.com/us/app/collaction-power-to-the-crowd/id1597643827"}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final bioController = TextEditingController();

    return BlocProvider<ProfileBloc>.value(
      value: BlocProvider.of<ProfileBloc>(context),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          bioController.value =
              TextEditingValue(text: state.userProfile?.profile.bio ?? '');

          final scaffold = Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: kAlmostTransparent,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndTop,
            floatingActionButton: Column(
              children: [
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: share,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: kEnabledButtonColor,
                  ).merge(
                    ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return 5;
                          }
                          return 4;
                        },
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                    child: Icon(CollactionIcons.share),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () =>
                      context.router.push(const SettingsRoute()).then((_) {
                    context.read<ProfileBloc>().add(GetUserProfile());
                  }),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: Colors.white,
                    onPrimary: kPrimaryColor0,
                    tapTargetSize: MaterialTapTargetSize.padded,
                  ).merge(
                    ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return 5;
                          }
                          return 4;
                        },
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                    child: Icon(
                      CollactionIcons.settings,
                      color: kPrimaryColor300,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ProfilePicture(
                                    image: _image,
                                    profileImage: state
                                                .userProfile?.profile.avatar !=
                                            null
                                        ? '${dotenv.get('BASE_STATIC_ENDPOINT_URL')}/${state.userProfile?.profile.avatar}'
                                        : null,
                                    maxRadius: 50,
                                  ),
                                ),
                                if (state.isEditing == true) ...[
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => PhotoSelector(
                                            onSelected: (image) {
                                              setState(() => _image = image);
                                              context.router.pop("dialog");
                                            },
                                          ),
                                        );
                                      },
                                      backgroundColor: kAccentColor,
                                      mini: true,
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.userProfile?.profile.firstName ?? 'Hi ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  state.userProfile?.profile.lastName ??
                                      'There',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (state.userProfile != null) ...[
                            const SizedBox(height: 40),
                            const Text(
                              'About me',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                                color: Color(0xFF666666),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 10),
                            if (state.isEditing == true) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: bioController,
                                      cursorColor: kAccentColor,
                                      maxLength: 150,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      minLines: 3,
                                      maxLines: 5,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 17,
                                            color: kPrimaryColor400,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const SizedBox(width: 16),
                                  Text(
                                    'Maximum 150 characters',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: kPrimaryColor300,
                                        ),
                                  ),
                                ],
                              )
                            ] else ...[
                              Text(
                                state.userProfile?.profile.bio ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17,
                                      color: kPrimaryColor400,
                                    ),
                              ),
                            ],
                            const SizedBox(height: 40),
                            RichText(
                              text: TextSpan(
                                text: 'Joined ',
                                style: const TextStyle(
                                  color: kPrimaryColor200,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                                children: [
                                  TextSpan(
                                    text: state
                                        .userProfile?.user.formattedJoinDate,
                                    style: const TextStyle(
                                      color: kPrimaryColor300,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            TextButton(
                              key: const Key('save_edit_button'),
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                  (states) => state.isEditing == true
                                      ? Colors.white.withOpacity(0.1)
                                      : kAccentColor.withOpacity(0.1),
                                ),
                                backgroundColor: state.isEditing == true
                                    ? MaterialStateProperty.all(kAccentColor)
                                    : null,
                                minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity * 0.75, 52),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    side: const BorderSide(
                                      color: kAccentColor,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (state.isEditing == true) {
                                  /// TODO: Implement save profile image
                                  BlocProvider.of<ProfileBloc>(context).add(
                                    SaveProfile(
                                      bio: bioController.text,
                                      image: _image,
                                    ),
                                  );
                                } else {
                                  context
                                      .read<ProfileBloc>()
                                      .add(EditProfile());
                                }
                              },
                              child: Text(
                                state.isEditing == true
                                    ? 'Save changes'
                                    : 'Edit profile',
                                style: TextStyle(
                                  color: state.isEditing == true
                                      ? Colors.white
                                      : kAccentColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            if (state.isEditing == true) ...[
                              const SizedBox(height: 10),
                              TextButton(
                                key: const Key('cancel_edit_button'),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                    const Size(double.infinity * 0.75, 52),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(CancelEditProfile());

                                  _image = null;
                                  bioController.value = TextEditingValue(
                                    text: state.userProfile?.profile.bio ?? '',
                                  );
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: kAccentColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ] else ...[
                            // TODO only for MVP (remove later)
                            const SizedBox(height: 40),
                            PillButton(
                              text: 'Create account or sign in',
                              onTap: () => context.router
                                  .push(const AuthRoute())
                                  .then((_) {
                                // Refresh profile
                                context
                                    .read<ProfileBloc>()
                                    .add(GetUserProfile());
                              }),
                            ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    UserProfileTab(user: state.userProfile?.user),
                  ],
                ),
              ),
            ),
          );

          return BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state.wasProfilePictureUpdated == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Profile picture will be reviewed!"),
                    duration: Duration(seconds: 5),
                  ),
                );
              }
            },
            child: scaffold,
          );
        },
      ),
    );
  }
}
