// ignore_for_file: constant_identifier_names

const participation1 = """{
  "id": "12345678",
  "crowdActionId": "123456",
  "fullName": "John Doe",
  "avatar": "/avatar/123456.png",
  "userId": "1234-1234-1234-1234",
  "commitments": ["1234"],
  "joinDate": "2024-01-01T00:00:00.000+00:00",
  "dailyCheckIns": 10
}""";

const participation2 = """{
      "id": "1234567890",
      "crowdActionId": "123456",
      "fullName": "John Doe 2",
      "avatar": "/avatar/123456.png",
      "userId": "1234-1234-1234-1234-1234-1234",
      "commitments": ["1234"],
      "joinDate": "2024-01-01T00:00:00.000+00:00",
      "dailyCheckIns": 10
    }""";

const participation3 = """{
      "id": "123456789",
      "crowdActionId": "123456",
      "fullName": "Jane Doe",
      "avatar": "/avatar/123456.png",
      "userId": "1234-1234-1234-1234-1234",
      "commitments": ["1234"],
      "joinDate": "2024-01-01T00:00:00.000+00:00",
      "dailyCheckIns": 10
    }""";

const participation4 = """{
      "id": "123456789",
      "crowdActionId": "123456",
      "fullName": "Jane Doe 2",
      "avatar": "/avatar/123456.png",
      "userId": "1234-1234-1234-1234-1234-1234-1234",
      "commitments": ["1234"],
      "joinDate": "2024-01-01T00:00:00.000+00:00",
      "dailyCheckIns": 10
    }""";

enum ParticipationFixtures {
  PAGE_1_WITH_USER("""{
  "pageInfo": {
    "page": 1,
    "pageSize": 2,
    "totalPages": 2,
    "totalItems": 4
  },
  "items": [
    $participation2,
    $participation1
  ]
}"""),

  PAGE_1_WITH_USER_AS_FIRST("""{
  "pageInfo": {
    "page": 1,
    "pageSize": 2,
    "totalPages": 2,
    "totalItems": 4
  },
  "items": [
    $participation1,
    $participation2
  ]
}"""),

  PAGE_1_WITHOUT_USER("""{
  "pageInfo": {
    "page": 1,
    "pageSize": 2,
    "totalPages": 2,
    "totalItems": 4
  },
  "items": [
    $participation2,
    $participation3
  ]
}"""),

  PAGE_2_WITH_USER("""{
  "pageInfo": {
    "page": 2,
    "pageSize": 2,
    "totalPages": 2,
    "totalItems": 4
  },
  "items": [
    $participation2,
    $participation1
  ]
}"""),

  PAGE_2_WITHOUT_USER("""{
  "pageInfo": {
    "page": 2,
    "pageSize": 2,
    "totalPages": 2,
    "totalItems": 4
  },
  "items": [
    $participation2,
    $participation3
  ]
}""");

  final String json;

  const ParticipationFixtures(this.json);
}
