# GitHub related documentation

## Workflows
_(TODO)_

## Repository secrets
The following repository secrets are used by workflows:

### Android
| Secret | Explanation
|---|---|
|`ANDROID_ALIAS`|Alias of the Android signing key|
|`ANDROID_GOOGLE_SERVICES_JSON`| _google-services.json_ downloaded from Firebase console as a base64 string|
|`ANDROID_KEY_PASSWORD`|Password of the Android signing key|
|`ANDROID_KEY_STORE_PASSWORD`|Password of the Android singing key keystore|
|`ANDROID_SIGNING_KEY`| Android keystore (_.jks_) file as base64 string|

### Firebase
| Secret | Explanation
|---|---|
|`FIREBASE_ANDROID_APP_ID`|Id of the Android app inside the Firebase console|
|`FIREBASE_TOKEN`|Firebase refresh token obtained from CLI ([instructions](https://firebase.google.com/docs/cli#cli-ci-systems))|
