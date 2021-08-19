import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@module
abstract class HttpSingleton {
  @lazySingleton
  http.Client get client => http.Client();
}
