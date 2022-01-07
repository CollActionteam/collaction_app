import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../themes/constants.dart';

class PhotoSelector extends StatefulWidget {
  final Function(File)? onSelected;

  const PhotoSelector({Key? key, this.onSelected}) : super(key: key);

  @override
  _PhotoSelectorState createState() => _PhotoSelectorState();
}

class _PhotoSelectorState extends State<PhotoSelector> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile Photo",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (image != null) {
                          if (mounted) {
                            if (_fileNotAnImage(image)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "File must be an image (JPG or PNG)",
                                  ),
                                ),
                              );
                              return;
                            }
                          }

                          _cropImage(image);
                        }
                      },
                      elevation: 0,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: const Icon(Icons.image),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Gallery")
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () async {
                        final XFile? image =
                            await _picker.pickImage(source: ImageSource.camera);

                        if (image != null) {
                          if (mounted) {
                            if (_fileNotAnImage(image)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "File must be an image (JPG or PNG)",
                                  ),
                                ),
                              );
                              return;
                            }
                          }

                          _cropImage(image);
                        }
                      },
                      elevation: 0,
                      backgroundColor: Colors.deepOrangeAccent,
                      child: const Icon(Icons.photo_camera),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Camera")
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  final _compression = 100;
  Future<void> _cropImage(XFile image) async {
    final File? croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressFormat: ImageCompressFormat.png,
      maxWidth: 1023,
      maxHeight: 1023,
      compressQuality: _compression,
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Profile Photo',
        toolbarColor: kAccentColor,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
        aspectRatioLockEnabled: true,
        title: 'Profile Photo',
      ),
    );

    if (widget.onSelected != null && croppedFile != null) {
      widget.onSelected!(croppedFile);
    }
  }

  /// Validates MimeType if mimetype is present
  ///
  /// [file] The file to validate
  bool _fileNotAnImage(XFile file) {
    final mimeType = file.mimeType ?? 'image';
    if (!mimeType.contains('image')) {
      return true;
    }
    return false;
  }
}
