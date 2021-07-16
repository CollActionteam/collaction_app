class CrowdActionModel {
  String? title;
  String? subtitle;
  List<String>? tags;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  int? numParticipants;
  int? participantsGoal;

  CrowdActionModel({
    this.title,
    this.subtitle,
    this.tags,
    this.description,
    this.startDate,
    this.endDate,
    this.numParticipants,
    this.participantsGoal,
  });
}
