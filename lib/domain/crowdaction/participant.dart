class Participant {
  final String? photo;
  final String name;

  Participant(this.photo, this.name);
}

final sampleParticipants = [
  Participant("https://source.unsplash.com/mEZ3PoFGs_k/500x500", "Barbara"),
  Participant("https://source.unsplash.com/L2dTmhQzx4Q/500x500", "Mike"),
  Participant("https://source.unsplash.com/WNoLnJo7tS8/500x500", "John")
];

final participantsPageParticipants = List.generate(10, (index) => index)
    .expand((element) => [
          Participant(
              "https://source.unsplash.com/mEZ3PoFGs_k/500x500", "Barbara"),
          Participant("https://source.unsplash.com/L2dTmhQzx4Q/500x500",
              "Barbara With A Very Long Name That Spans Two Lines"),
        ])
    .toList();

extension ParticipantsX on List<Participant> {
  String title(int totalParticipants) {
    if (totalParticipants >= 3 && length >= 3) {
      return "${take(2).map((e) => e.name).join(", ")} and ${totalParticipants - 2} others!";
    } else {
      return map((e) => e.name).join(" and ");
    }
  }
}
