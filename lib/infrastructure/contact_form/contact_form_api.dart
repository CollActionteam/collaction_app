import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../domain/contact_form/contact_form_dto.dart';
import '../../domain/contact_form/i_contact_form_api.dart';
import '../../domain/core/i_settings_repository.dart';

@LazySingleton(as: IContactFormApi)
class ContactFormApi extends IContactFormApi {
  final http.Client client;
  final ISettingsRepository settingsRepository;
  ContactFormApi(this.client, this.settingsRepository);

  /// TODO: Use Either<ContactFormFailure, Unit> in the future
  @override
  Future<bool> sendContactFormContents(ContactFormDto contents) async {
    final packageInfo = await PackageInfo.fromPlatform();
    try {
      final response = await client.post(
        Uri.parse('${await settingsRepository.baseApiEndpointUrl}/contact'),
        body: json.encode({
          ...contents.toJson(),
          "app_version":
              "${Platform.operatingSystem} ${packageInfo.version}+${packageInfo.buildNumber}"
        }),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (exception, stackTrace) {
      Sentry.captureException(exception, stackTrace: stackTrace);
      return false;
    }
  }
}
