import 'package:flutter_test/flutter_test.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'commitment_option_dto_fixtures.dart';

void main() {
  group('unit tests for CommitmentDto', () {
    test('toDomain() test', () {
      final commitment = tCommitmentDto.toDomain();

      expect(commitment, tCommitment);
    });

    test('fromJson() test', () {
      final commitmentDto = CommitmentDto.fromJson(tCommitmentJson);

      expect(commitmentDto, tCommitmentDto);
    });
  });
}
