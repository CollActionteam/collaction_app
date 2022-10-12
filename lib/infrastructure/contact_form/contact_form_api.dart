import 'dart:convert';
import 'dart:io';

import 'package:collaction_app/domain/contact_form/contact_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/contact_form/contact_form_dto.dart';
import '../../domain/contact_form/i_contact_form_api.dart';
import '../../domain/core/i_settings_repository.dart';

@LazySingleton(as: IContactRepository)
class ContactRepository extends IContactRepository {
  final http.Client client;
  final ISettingsRepository settingsRepository;

  ContactRepository(this.client, this.settingsRepository);

  @override
  Future<Either<ContactFailure, Unit>> sendContactFormContents(
    ContactFormDto contents,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('${await settingsRepository.baseApiEndpointUrl}/v1/contact'),
        body: json.encode({
          'email': contents.email,
          'title': contents.subject,
          'body': contents.message,
        }),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == HttpStatus.created) {
        return right(unit);
      } else {
        return left(const ContactFailure.serverError());
      }
    } catch (_) {
      return left(const ContactFailure.unexpectedError());
    }
  }
}
