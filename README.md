# CollAction Application

CollAction cross-platform mobile application (iOS / Android).

## Getting Started

To start contributing to the CollAction Application, there are a few steps you will have to go through.

Steps to take:
- [Install Flutter](https://flutter.dev/docs/get-started/install)
- [Set up an editor, e.g. Android Studio](https://flutter.dev/docs/get-started/editor?tab=androidstudio)

Once your local environment is ready for Flutter development, you can fork the repository and clone it locally.

## Code Generation

In order to generate code related to `freezed`, `injectable`, `json_serializable`, etc. choose a command to run when you need to build or re-build these files:

_The watch command keeps re-building generated files. It is generally not recommended to use._
```bash
  flutter pub run build_runner watch --delete-conflicting-outputs
```
_If you want to build once you are done with your changes, to build generated files once run this command, it's preferred._
```bash
  flutter pub run build_runner build --delete-conflicting-outputs
```

## Firebase
In order to use features provided by Firebase, download the corresponding `google-services.json` and `GoogleService-Info.plist` from the Firebase console project and add them to the project files.

Make sure that the SHA fingerprint of your signing certificate (Android) and AppStoreID/TeamID (iOS) are registered in your Firebase console.

More information:
* [Signing an Android application](https://developer.android.com/studio/publish/app-signing#sign_release)
* [Finding the SHA fingerprint](https://developers.google.com/android/guides/client-auth).

Phone authentication has to be enabled in the Firebase console.

## Getting Started with Flutter

A few resources to get you started if this is your first Flutter project:
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
