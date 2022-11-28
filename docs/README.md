# CollAction Application

CollAction cross-platform mobile application (iOS / Android).

## Getting Started

To start contributing to the CollAction Application, there are a few steps you will have to go
through.

Steps to take:

- [Install Flutter](https://flutter.dev/docs/get-started/install)
- [Set up an editor, e.g. Android Studio](https://flutter.dev/docs/get-started/editor?tab=androidstudio)

Once your local environment is ready for Flutter development, you can fork the repository and clone
it locally.

## Code Generation

In order to generate code related to `freezed`, `injectable`, `json_serializable`, etc. choose a
command to run when you need to build or re-build these files:

_The watch command keeps re-building generated files. It is generally not recommended to use._

```bash
  flutter pub run build_runner watch -d
```

_If you want to build generated files once run this command, it's preferred._

```bash
  flutter pub run build_runner build -d
```

Note: The argument `-d` is shorthand for `--delete-conflicting-outputs` introduced in build_runner 2.3.0

## Imutable app settings

We use an environment file called `.env` to define secrets used in the application. `
These secrets are bundled with the application at build-time.

Make a copy of the `.env.example` file, name it `.env` and fill out the missing secrets.

## Firebase

In order to use features provided by Firebase, download the corresponding `google-services.json`
and `GoogleService-Info.plist` from the Firebase console project and add them to the project files.

Phone authentication has to be enabled in the Firebase console.

You can find phone numbers to use for testing in the Firebase Console by navigating to
Authentication > Sign-in method > Sign in providers > Phone > Phone numbers for testing

## Adding new icon svg

To update the icons font with a new svg, go to [FlutterIcons](https://www.fluttericon.com/)

- Appended to the `Download` button is a settings button, tap that and choose `Import`.
- Browse to your project folder and choose the [config.json](../assets/fonts/icons/config.json) file
  that contains the font configuration. That should restore the existing font.
- Drag your svg to the `Custom Icons` section then select it.
- Switch to the names tab right next to the icons tab.
- Give your icon an appropriate name then `Download`
- Replace the corresponding [config.json](../assets/fonts/icons/config.json)
  ,[collaction.ttf](../assets/fonts/icons/collaction.ttf)
  and [collaction_icons.dart](../lib/presentation/core/collaction_icons.dart) files in the project.
- Use your new icon

> Note: If the icon preview in [FlutterIcons](https://www.fluttericon.com/) is not how you expect the icon to look, reach out to the design team to help flatten the svg.

## Generating OpenSource Licenses

To generate the OpenSource licenses dart file via [flutter_oss_licenses](https://pub.dev/packages/flutter_oss_licenses), run the command `flutter pub run flutter_oss_licenses:generate.dart lib/presentation/licenses/oss_licenses.dart` from the project root.

> Note: Run `flutter format .` once [oss_licenses.dart](../lib/presentation/licenses/oss_licenses.dart) is created.

## Running tests and generating Test Report

- Step 1: Just for the 1st time, to make sure that all files are included, run `./.github/scripts/coverage_gen.sh` to generate a report for the whole project.
- Step 2: Run `flutter test --coverage`. This will generate the report locally.
- Step 3: Run `genhtml coverage/lcov.info -o coverage`.
- Step 4: Run ` firefox coverage/index.html` (or run `coverage/index.html` to any of your web browser).

#### You should see the coverage of your tests line-wise in Codecov.

## Getting Started with Flutter

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on
mobile development, and a full API reference.

## Pre-push checks

We have set up Git hooks to prevent extra whitespace and other possible mistakes before pushing the code to your branch. Run the below command in the project root directory to copy the pre-push hooks to your local `.git` directory.

```bash
  cp ./hooks/* ./.git/hooks/
```
