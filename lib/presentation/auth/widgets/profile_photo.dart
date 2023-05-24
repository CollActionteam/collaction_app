import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../../application/user/avatar/avatar_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../shared_widgets/photo_selector.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';

class SelectProfilePhoto extends StatefulWidget {
  final Function() onSkip;

  const SelectProfilePhoto({super.key, required this.onSkip});

  @override
  SelectProfilePhotoState createState() => SelectProfilePhotoState();
}

class SelectProfilePhotoState extends State<SelectProfilePhoto> {
  bool _isPhotoValid = false;
  File? _photo;
  late final AvatarBloc avatarBloc;

  @override
  void initState() {
    super.initState();
    avatarBloc = getIt<AvatarBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AvatarBloc>(
      create: (context) => avatarBloc,
      child: BlocListener<AvatarBloc, AvatarState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            uploading: () {
              /// TODO: Loading indication
            },
            uploadSuccess: context.pop,
            uploadFailed: () {
              /// TODO: Show error snackbar | Implement failures
            },
          );
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 50.0,
                          foregroundImage:
                              _photo != null ? FileImage(_photo!) : null,
                          backgroundImage: const AssetImage(
                            'assets/images/default_avatar.png',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: FloatingActionButton(
                          onPressed: () => PhotoSelector.showPhotoSelector(
                            context,
                            onSelected: (File photo) {
                              setState(() {
                                _photo = photo;
                                _isPhotoValid = true;
                              });
                            },
                          ),
                          backgroundColor: kAccentColor,
                          mini: true,
                          child: const Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Upload a profile\r\n picture',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32.0,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'We love to see happy faces',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kInactiveColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 41.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PillButton(
                          text: 'Next',
                          isEnabled: _isPhotoValid,
                          isLoading: state is AwaitingProfilePhotoUpdate,
                          onTap: () {
                            if (_isPhotoValid &&
                                state is! AwaitingProfilePhotoUpdate) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.updateProfilePhoto(_photo!));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => widget.onSkip.call(),
                          child: const Text(
                            'Maybe later',
                            style: TextStyle(
                              color: kAccentColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
