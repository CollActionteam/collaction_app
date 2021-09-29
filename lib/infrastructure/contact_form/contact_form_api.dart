import 'dart:convert';
import 'dart:io';

import 'package:collaction_app/domain/i_settings_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../domain/contact_form/contact_form_contents.dart';
import '../../domain/contact_form/i_contact_form_api.dart';

@LazySingleton(as: IContactFormApi)
class ContactFormApi extends IContactFormApi {
  final http.Client client;
  final ISettingsRepository settingsRepository;
  ContactFormApi(this.client, this.settingsRepository);

  @override
  Future<bool> sendContactFormContents(ContactFormContents contents) async {
    assert(contents.email != null);
    assert(contents.message != null);
    final platform =
        Platform.isAndroid ? 'android' : (Platform.isIOS ? 'ios' : 'unknown');

    final packageInfo = await PackageInfo.fromPlatform();
    // ignore: prefer_interpolation_to_compose_strings
    final bodyJson = '{"email":"${contents.email}",' +
        // TODO add subject to ContactFormContents class
        '"subject":"Hello CollAction!",' +
        '"message":"${contents.message?.replaceAll('"', '\\"')}",' +
        '"app_version":"$platform ${packageInfo.version}+${packageInfo.buildNumber}"}';
    return client
        .post(
            Uri.parse('${await settingsRepository.baseApiEndpointUrl}/contact'),
            encoding: Encoding.getByName('application/json'),
            body: bodyJson)
        .then((value) => value.statusCode == 200)
        .onError((error, stackTrace) => false);
  }
}
