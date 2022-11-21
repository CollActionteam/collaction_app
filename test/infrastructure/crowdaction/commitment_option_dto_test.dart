import 'package:flutter_test/flutter_test.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'commitment_option_dto_fixtures.dart';

void main() {
  group('unit tests for CommitmentOptionDto', () {
    test('toDomain() test', () {
      final commitmentOption = tCommitmentOptionDto.toDomain();

      expect(commitmentOption, tCommitmentOption);
    });
    test('fromJson() test', () {
      final commitmentOptionDto =
          CommitmentOptionDto.fromJson(tCommitmentOptionJson);

      expect(commitmentOptionDto, tCommitmentOptionDto);
    });
  });
}
