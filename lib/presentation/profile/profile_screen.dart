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
                    backgroundColor: kEnabledButtonColor,
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
                                if (state.userProfile != null) ...[
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: FloatingActionButton(
                                      onPressed: () =>
                                          PhotoSelector.showPhotoSelector(
                                        context,
                                        onSelected: (image) {
                                          setState(() => _image = image);
                                          BlocProvider.of<ProfileBloc>(context)
                                              .add(
                                            SaveProfilePic(image: image),
                                          );
                                        },
                                      ),
                                      backgroundColor: kAccentColor,
                                      mini: true,
                                      child: const Icon(
                                        Icons.drive_file_rename_outline,
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              state.userProfile?.profile.firstName ?? 'You',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          if (state.userProfile != null) ...[
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'About me',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    color: Color(0xFF666666),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                TextButton(
                                  key: const Key('save_edit_bio_button'),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (state.isBioEditing == true) {
                                      /// TODO: Implement save profile image
                                      BlocProvider.of<ProfileBloc>(context).add(
                                        SaveBio(
                                          bio: bioController.text,
                                        ),
                                      );
                                    } else {
                                      context
                                          .read<ProfileBloc>()
                                          .add(EditBio());
                                    }
                                  },
                                  child: Text(
                                    state.isBioEditing == true
                                        ? 'Save'
                                        : 'Edit',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: kAccentColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (state.isBioEditing == true) ...[
                              //idhr bio editing start
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
                                          .bodyMedium!
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Maximum 150 characters',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
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
                                    .bodyMedium!
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
                          ] else ...[
                            const SizedBox(height: 40),
                            PillButton(
                              text: 'Sign in',
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
