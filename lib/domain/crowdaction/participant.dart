import 'package:freezed_annotation/freezed_annotation.dart';

import 'crowdaction.dart';
part 'participant.freezed.dart';
part 'participant.g.dart';

@freezed
class Participant with _$Participant {
  factory Participant({
    required String userId,
    required String avatar,
    required String fullName,
  }) = _Participant;

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);
}

final sampleParticipants = [
  Participant(
    userId: 'ashdgvfasdbhsvfda',
    avatar: "https://source.unsplash.com/mEZ3PoFGs_k/500x500",
    fullName: "Barbara",
  ),
  Participant(
    userId: 'ashdgvfasdbhsvfdb',
    avatar: "https://source.unsplash.com/L2dTmhQzx4Q/500x500",
    fullName: "Mike",
  ),
  Participant(
    userId: 'ashdgvfasdbhsvfdc',
    avatar: "https://source.unsplash.com/WNoLnJo7tS8/500x500",
    fullName: "John",
  )
];

/// TODO - Switch Participants to BLOC
final participantsPageParticipants = List.generate(10, (index) => index)
    .expand(
      (element) => [
        Participant(
          userId: 'asdhvfg',
          avatar: "https://source.unsplash.com/mEZ3PoFGs_k/500x500",
          fullName: "Barbara",
        ),
        Participant(
          userId: 'asjkdbhvf',
          avatar: "https://source.unsplash.com/L2dTmhQzx4Q/500x500",
          fullName: "Barbara With A Very Long Name That Spans Two Lines",
        ),
      ],
    )
    .toList();

extension ParticipantsX on List<TopParticipant> {
  String title(int totalParticipants) {
    if (totalParticipants >= 3 && length >= 3) {
      return "${take(2).map((e) => e.name).join(", ")} and ${totalParticipants - 2} others!";
    } else {
      return map((e) => e.name).join(" and ");
    }
  }
}
