import 'dart:math';

import 'package:collaction_app/models/crowd_action_model.dart';
import 'package:collaction_app/dummy_data.dart';

class Parser {
  static List<CrowdActionModel> parseCollactionActionString(String input) {
    List<CrowdActionModel> dummies = DummyData.dummyModels;
    List<CrowdActionModel> moreDummies = DummyData.moreDummyTitles.map((title) {
      Random random = Random();
      int participants = random.nextInt(1000);
      int participantsGoal = random.nextInt(2000);
      return CrowdActionModel(
        title: title,
        numParticipants: participants,
        participantsGoal: participantsGoal,
      );
    }).toList();

    return dummies + moreDummies;
  }
}
