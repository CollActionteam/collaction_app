import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../shared_widgets/photo_selector.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';

class SelectProfilePhoto extends StatefulWidget {
  final Function() onSkip;

  const SelectProfilePhoto({Key? key, required this.onSkip}) : super(key: key);

  @override
  _SelectProfilePhotoState createState() => _SelectProfilePhotoState();
}

class _SelectProfilePhotoState extends State<SelectProfilePhoto> {
  bool _isPhotoValid = false;
  File? _photo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext buildContext) => PhotoSelector(
                  onSelected: (File photo) {
                    setState(() {
                      _photo = photo;
                      _isPhotoValid = true;
                    });

                    context.router.pop();
                  },
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: kAlmostTransparent,
                      radius: 50.0,
                      backgroundImage:
                          _photo != null ? FileImage(_photo!) : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: kAccentColor,
                      mini: true,
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'Upload a profile\r\n picture',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 32.0),
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
                    onPressed: widget.onSkip,
                    child: const Text(
                      'Maybe later',
                      style: TextStyle(
                          color: kAccentColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
