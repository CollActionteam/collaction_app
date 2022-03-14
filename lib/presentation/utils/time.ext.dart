extension DateX on DateTime {
  /// Convert [DateTime] to comment readable String
  ///
  /// Assume a month has 31 days
  String toCommentTime() {
    final seconds = (DateTime.now().difference(this)).inSeconds;

    var interval = seconds / 31536000;

    if (interval > 1) {
      return "${interval.floor()} years";
    }

    interval = seconds / 2592000;
    if (interval > 1) {
      return "${interval.floor()} months";
    }

    interval = seconds / 604800;
    if (interval > 1) {
      return "${interval.floor()} weeks";
    }

    interval = seconds / 86400;
    if (interval > 1) {
      return "${interval.floor()} days";
    }

    interval = seconds / 3600;
    if (interval > 1) {
      return "${interval.floor()} hours";
    }

    interval = seconds / 60;
    if (interval > 1) {
      return "${interval.floor()} minutes";
    }

    return "$seconds seconds";
  }
}
