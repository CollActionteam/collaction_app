import 'package:collaction_app/models/crowd_action_model.dart';
import 'package:collaction_app/api/parser.dart';

class API {
  static Future<List<CrowdActionModel>> fetchCrowdActions() async {
    await Future.delayed(Duration(seconds: 1));
    String response = await _fetchCrowdActionsString();
    List<CrowdActionModel> models = Parser.parseCollactionActionString(response);
    return models;
  }

  static Future<String> _fetchCrowdActionsString() async {
    return '';
  }
}