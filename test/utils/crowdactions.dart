import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';

final _crowdActionsRawData = [
  {
    "id": "62ceb7110b5e88ce294628a1",
    "title": "Veganuary",
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam varius ac ligula quis aliquet. Donec nisi leo, rhoncus ac nulla quis, egestas ornare quam. Nunc nibh ex, venenatis quis maximus vitae, elementum sed urna. Morbi sagittis metus nibh, non lacinia ipsum faucibus eu. Nulla vehicula purus eget congue auctor.",
    "category": "SUSTAINABILITY",
    "subcategory": "FOOD",
    "location": {"code": "NL", "name": "Netherlands"},
    "slug": "veganuary",
    "password": "veganuary-2022",
    "participantCount": 9,
    "images": {
      "card": "crowdaction-cards/628a7fa741b5aa3af6582a07.png",
      "banner": "crowdaction-banners/628a7fa741b5aa3af6582a07.png"
    },
    "commitments": [
      {
        "label": "5/7 Days a week",
        "description": "In case you prefer to exclude weekends",
        "points": -10,
        "blocks": [],
        "id": "62b637e0c5d78b613a3cc6d2"
      },
      {
        "label": "Vegan",
        "description":
            "Commit to eating no product or by-product from any and all animals",
        "points": 50,
        "blocks": [
          "62b63863c5d78b613a3cc6d6",
          "62b638a6c5d78b613a3cc6d8",
          "62b638c8c5d78b613a3cc6da",
          "62b638d9c5d78b613a3cc6dc"
        ],
        "id": "62b6381fc5d78b613a3cc6d4"
      },
      {
        "label": "Vegetarian",
        "description":
            "Commit to eating no meat product or by-product of any and all animals",
        "points": 40,
        "blocks": ["62b638a6c5d78b613a3cc6d8", "62b638c8c5d78b613a3cc6da"],
        "id": "62b63863c5d78b613a3cc6d6"
      },
      {
        "label": "Pescatarian",
        "description":
            "Commit to eating no meat or poultry from animals, except fish and other seafood",
        "points": 30,
        "blocks": ["62b638c8c5d78b613a3cc6da"],
        "id": "62b638a6c5d78b613a3cc6d8"
      },
      {
        "label": "No Beef",
        "description": "Commit to eating no beef",
        "points": 20,
        "blocks": [],
        "id": "62b638c8c5d78b613a3cc6da"
      },
      {
        "label": "No Dairy",
        "description":
            "Commit to eating no dairy products such as cheese and milk",
        "points": 10,
        "blocks": [],
        "id": "62b638d9c5d78b613a3cc6dc"
      }
    ],
    "status": "STARTED",
    "joinStatus": "OPEN",
    "startAt": "2022-07-22T15:00:00.000Z",
    "endAt": "2024-12-22T15:00:00.000Z",
    "joinEndAt": "2023-12-22T15:00:00.000Z",
    "createdAt": "2022-07-13T12:14:09.104Z",
    "updatedAt": "2022-11-19T23:06:11.947Z",
    "badges": []
  },
  {
    "id": "6364ca939d4f5dffc3fe8e25",
    "title": "Steun je School",
    "description":
        "Tijdens deze campagne staat het thema energiebesparing centraal, in het bijzonder op scholen. We bevinden ons in een energiecrisis en alleen samen komen we eruit! Voor meer informatie, neem een kijkje op collaction.org/steunschool.",
    "category": "Duurzaamheid",
    "subcategory": "Energie",
    "location": {"code": "NL", "name": "Netherlands"},
    "slug": "steun-je-school",
    "password": "",
    "participantCount": 3,
    "images": {
      "card": "crowdaction-cards/education_january.jpg",
      "banner": "crowdaction-banners/education_january.jpg"
    },
    "commitments": [
      {
        "label": "SUSTAINABILITY",
        "description": "",
        "points": 10,
        "blocks": [],
        "id": "6364bcbf9d4f5dffc3fe8e19"
      }
    ],
    "status": "STARTED",
    "joinStatus": "OPEN",
    "startAt": "2022-12-31T23:00:00.000Z",
    "endAt": "2023-01-31T23:00:00.000Z",
    "joinEndAt": "2023-01-31T23:00:00.000Z",
    "createdAt": "2022-07-13T12:14:09.104Z",
    "updatedAt": "2022-12-31T23:00:00.431Z",
    "badges": []
  },
  {
    "id": "6364d440187f67b3798ca86e",
    "title": "The Food Initiative",
    "description":
        "Improve your eating habits, and downscale your CO2 footprint!",
    "category": "SUSTAINABILITY",
    "subcategory": "FOOD",
    "location": {"code": "NL", "name": "Netherlands"},
    "slug": "the-food-initiative",
    "participantCount": 0,
    "images": {
      "card": "crowdaction-cards/placeholder.png",
      "banner": "crowdaction-banners/placeholder.png"
    },
    "commitments": [
      {
        "label": "5/7 Days a week",
        "description": "In case you prefer to exclude weekends",
        "points": -10,
        "blocks": [],
        "icon": "working-days-only",
        "id": "62b637e0c5d78b613a3cc6d2"
      },
      {
        "label": "Vegan",
        "description": "Commit to eating no product or by-product from animals",
        "points": 50,
        "blocks": [
          "62b63863c5d78b613a3cc6d6",
          "62b638a6c5d78b613a3cc6d8",
          "62b638c8c5d78b613a3cc6da",
          "62b638d9c5d78b613a3cc6dc"
        ],
        "icon": "vegan",
        "id": "62b6381fc5d78b613a3cc6d4"
      },
      {
        "label": "Vegetarian",
        "description":
            "Commit to eating no meat product or by-product from animals",
        "points": 40,
        "blocks": ["62b638a6c5d78b613a3cc6d8", "62b638c8c5d78b613a3cc6da"],
        "icon": "vegetarian",
        "id": "62b63863c5d78b613a3cc6d6"
      },
      {
        "label": "Pescatarian",
        "description":
            "Commit to eating no meat or poultry from animals, except fish and other seafood",
        "points": 30,
        "blocks": ["62b638c8c5d78b613a3cc6da"],
        "icon": "pescatarian",
        "id": "62b638a6c5d78b613a3cc6d8"
      },
      {
        "label": "No Beef",
        "description": "Commit to eating no beef",
        "points": 20,
        "blocks": [],
        "icon": "no-beef",
        "id": "62b638c8c5d78b613a3cc6da"
      },
      {
        "label": "No Dairy",
        "description":
            "Commit to eating no dairy products such as cheese and milk",
        "points": 10,
        "blocks": [],
        "icon": "no-dairy",
        "id": "62b638d9c5d78b613a3cc6dc"
      }
    ],
    "status": "WAITING",
    "joinStatus": "OPEN",
    "startAt": "2022-11-04T15:00:00.000Z",
    "endAt": "2024-12-22T15:00:00.000Z",
    "joinEndAt": "2023-12-22T15:00:00.000Z",
    "createdAt": "2022-11-04T08:58:40.237Z",
    "updatedAt": "2022-11-04T08:58:40.237Z",
    "badges": [
      {"tier": "DIAMOND", "awardType": "TIER", "minimumCheckIns": 0},
      {"tier": "GOLD", "awardType": "ALL", "minimumCheckIns": 0}
    ]
  }
];

final crowdActions =
    _crowdActionsRawData.map((e) => CrowdActionDto.fromJson(e)).toList();
