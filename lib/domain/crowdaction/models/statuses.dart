part of '../crowdaction.dart';

enum Status {
  started,
  waiting,
  ended,
}

extension StatusFromJsonExtension on String {
  Status get fromStatusJson {
    switch (this) {
      case 'STARTED':
        return Status.started;
      case 'WAITING':
        return Status.waiting;
      case 'ENDED':
        return Status.ended;
      default:
        throw Exception('Invalid status $this');
    }
  }
}

extension StatusToJsonExtension on Status {
  String get toJson {
    switch (this) {
      case Status.started:
        return 'STARTED';
      case Status.waiting:
        return 'WAITING';
      case Status.ended:
        return 'ENDED';
    }
  }
}

enum JoinStatus {
  open,
  closed,
}

extension JoinStatusFromJsonExtension on String {
  JoinStatus get fromJoinStatusJson {
    switch (this) {
      case 'OPEN':
        return JoinStatus.open;
      case 'CLOSED':
        return JoinStatus.closed;
      default:
        throw Exception('Invalid status $this');
    }
  }
}

extension JoinStatusToJsonExtension on JoinStatus {
  String get toJson {
    switch (this) {
      case JoinStatus.open:
        return 'OPEN';
      case JoinStatus.closed:
        return 'CLOSED';
    }
  }
}
