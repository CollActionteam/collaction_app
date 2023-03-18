import 'dart:convert';
import 'package:collaction_app/domain/contact_form/i_contact_form_repository.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/contact_form/contact_failures.dart';
import 'package:http/http.dart' as http;

import 'package:collaction_app/infrastructure/contact_form/contact_form_repository.dart';
import './contact_form_dto_fixtures.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../test_utilities.dart';

const baseUrl = 'https://example.com';
void main() {
  late http.Client client;
  late ISettingsRepository settingsRepository;
  late IContactRepository contactRepository;

  setUp(() {
    client = MockHttpClient();
    settingsRepository = MockSettingsRepository();
    contactRepository = ContactRepository(client, settingsRepository);

    when(() => settingsRepository.baseApiEndpointUrl)
        .thenAnswer((_) async => baseUrl);
  });

  group('create contact: ', () {
    final contactPostUrl = Uri.parse('$baseUrl/v1/contact');
    final contactPostHeader = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    String expectedBody = json.encode({
      'email': tContactFormDto.email,
      'title': tContactFormDto.subject,
      'body': tContactFormDto.message
    });

    test("successful api call", () async {
      // mock data
      when(() => client.post(contactPostUrl,
          body: expectedBody,
          headers: contactPostHeader)).thenAnswer((_) async {
        return http.Response('', 201);
      });

      // perform test
      final result =
          await contactRepository.sendContactFormContents(tContactFormDto);

      // verify
      verify(() => client.post(contactPostUrl,
          body: expectedBody, headers: contactPostHeader)).called(1);
      expect(result.isRight(), equals(true));
    });
    test("fail response from call", () async {
      // mock data
      when(() => client.post(contactPostUrl,
          body: expectedBody,
          headers: contactPostHeader)).thenAnswer((_) async {
        return http.Response('', 500);
      });

      // perform test
      final result =
          await contactRepository.sendContactFormContents(tContactFormDto);

      // verify
      verify(() => client.post(contactPostUrl,
          body: expectedBody, headers: contactPostHeader)).called(1);
      expect(result.isLeft(), equals(true));
      expect(result.fold((l) => l, (r) => r), ContactFailure.serverError());
    });
    test("anonymous failure", () async {
      // mock data
      when(() => client.post(contactPostUrl,
          body: expectedBody, headers: contactPostHeader)).thenThrow("error");

      // perform test
      final result =
          await contactRepository.sendContactFormContents(tContactFormDto);

      // verify
      verify(() => client.post(contactPostUrl,
          body: expectedBody, headers: contactPostHeader)).called(1);
      expect(result.isLeft(), equals(true));
      expect(result.fold((l) => l, (r) => r), ContactFailure.unexpectedError());
    });
  });
}
