import 'dart:io';

import 'package:flutter/material.dart';

import '../../shared_widgets/photo_selector.dart';
import '../../shared_widgets/rectangular_button.dart';
import '../../themes/constants.dart';

/// Profile Photo selection
class SelectProfilePhoto extends StatefulWidget {
  final Function() onNext;
  final Function() onSkip;

  const SelectProfilePhoto(
      {Key? key, required this.onNext, required this.onSkip})
      : super(key: key);

  @override
  _SelectProfilePhotoState createState() => _SelectProfilePhotoState();
}

class _SelectProfilePhotoState extends State<SelectProfilePhoto> {
  var _isPhotoValid = false;
  File? _photo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext buildContext) {
                return PhotoSelector(
                  onSelected: (File photo){
                    setState(() {
                      _photo = photo;
                      _isPhotoValid = true;
                      // TODO - Add photo to profile flow via bloc
                    });
                    Navigator.of(buildContext).pop();
                  },
                );
              },
            );
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: kAlmostTransparent,
                  radius: 50.0,
                  backgroundImage: _photo != null ? FileImage(_photo!): null,
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
                  ))
            ],
          ),
        ),
        const SizedBox(height: 30.0),
        Row(
          children: const [
            Expanded(
              child: Text(
                'Upload a profile\r\n picture',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32.0),
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
                'It’s always nice to put a face to your name!',
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
              child: RectangularButton(
                text: 'Next',
                isEnabled: _isPhotoValid,
                onPressed: () {
                  if (_isPhotoValid) {
                    widget.onNext();
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
                child: const Text('Skip for now',
                    style: TextStyle(
                        color: kAccentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0)),
              ),
            ),
          ],
        ),
      ],
    );
  }

}
