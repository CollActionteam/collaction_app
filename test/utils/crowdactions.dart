import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';

final _crowdActionsRawData = [
  {
    "crowdactionID": "sustainability#food#veganMonth21-12",
    "title": "Vegan month 2021",
    "description": "Let's be vegan for a month",
    "category": "sustainability",
    "location": "NL#Amsterdam",
    "date_start": "2021-12-01",
    "date_end": "2021-12-31",
    "date_limit_join": "2021-12-20",
    "password_join": "myEvent-myCompany2021",
    "commitment_options": [
      {
        "id": "vegetarian",
        "label": "Becoming vegetarian",
        "description":
            "I will not eat any meat from any animal (including fish).",
        "requires": [
          {
            "id": "no-beef",
            "label": "Not eating beef",
            "description": "I will avoid eating beef (Goodbye stake)."
          }
        ]
      }
    ],
    "participant_count": 1,
    "top_participants": [
      {"name": "Peter Parker", "userID": "6620cf87-44ed-456e-9798-d5cbeb7fa10a"}
    ],
    "images": {
      "card":
          "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1\u0026ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8\u0026auto=format\u0026fit=crop\u0026w=640",
      "banner":
          "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1\u0026ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8\u0026auto=format\u0026fit=crop\u0026w=640"
    }
  },
  {
    "crowdactionID": "sustainability#food#veganMonth22-12",
    "title": "Vegan month 2022",
    "description": "Let's be vegan for a month",
    "category": "sustainability",
    "location": "NL#Amsterdam",
    "date_start": "2022-12-01",
    "date_end": "2022-12-31",
    "date_limit_join": "2022-12-20",
    "password_join": "myEvent-myCompany2022",
    "commitment_options": [
      {
        "id": "vegetarian",
        "label": "Becoming vegetarian",
        "description":
            "I will not eat any meat from any animal (including fish).",
        "requires": [
          {
            "id": "no-beef",
            "label": "Not eating beef",
            "description": "I will avoid eating beef (Goodbye stake)."
          }
        ]
      }
    ],
    "participant_count": 1,
    "top_participants": [
      {"name": "Peter Parker", "userID": "6620cf87-44ed-456e-9798-d5cbeb7fa10a"}
    ],
    "images": {
      "card":
          "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1\u0026ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8\u0026auto=format\u0026fit=crop\u0026w=640",
      "banner":
          "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1\u0026ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8\u0026auto=format\u0026fit=crop\u0026w=640"
    }
  }
];

final crowdActions =
    _crowdActionsRawData.map((e) => CrowdActionDto.fromJson(e)).toList();
