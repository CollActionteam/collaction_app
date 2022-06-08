import 'dart:io';

import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:mocktail/mocktail.dart';

Future<String?> _getTestAnonymousIdToken([bool forceRefresh = false]) =>
    Future.value(null);
const tUser = User(id: 'tId', getIdToken: _getTestAnonymousIdToken);

class MockImageFile extends Mock implements File {}

const Credential tCredentials = Credential(
  verificationId: 'tVerId',
  smsCode: 'tCode',
);
