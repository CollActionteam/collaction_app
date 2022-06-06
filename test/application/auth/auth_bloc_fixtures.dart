import 'package:collaction_app/domain/user/user.dart';

Future<String?> _getTestAnonymousIdToken([bool forceRefresh = false]) =>
    Future.value(null);
const tUser = User(id: 'tId', getIdToken: _getTestAnonymousIdToken);
