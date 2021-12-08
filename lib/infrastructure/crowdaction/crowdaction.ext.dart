import 'crowdaction_dto.dart';

extension ListCrowdAction on List<CommitmentOption> {
  List<CommitmentOption> flatten({String? ref}) {
    final List<CommitmentOption> commitments = [];

    for (final commitment in this) {
      commitments.add(commitment.copyWith(ref: ref));

      final requiredCommitments = commitment.requires;
      if (requiredCommitments != null) {
        commitments.addAll(requiredCommitments.flatten(ref: commitment.ref));
      }
    }

    return commitments;
  }
}
