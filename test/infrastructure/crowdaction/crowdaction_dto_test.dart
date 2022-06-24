import 'package:collaction_app/infrastructure/crowdaction/crowdaction.ext.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../infrastructure_fixtures.dart';

void main() {
  group('Testing Crowdaction DTO', () {
    test('Testing toDomain() method', () {
      final tCrowdaction = tCrowdactionDto.toDomain();
      expect(tCrowdaction, tCrowdaction);
    });

    test('Testing ImagesDto factory', () {
      final imagesDto = ImagesDto.fromJson(imagesDtoJson);
      expect(imagesDto, tImagesDto);
    });

    test('Testing CommitmentOption factory method', () {
      final commitmentOptionDto =
          CommitmentOptionDto.fromJson(commitmentOptionJson);
      expect(commitmentOptionDto, commitmentOptionDto);
    });

    test('Testing TopParticipant factory method', () {
      final topParticipantDto = TopParticipantDto.fromJson(topParticipantJson);
      expect(topParticipantDto, tTopParticipantDto);
    });

    test('Testing CrowdAction factory method', () {
      final crowdactionDto = CrowdActionDto.fromJson(crowdactionDtoJson);
      expect(crowdactionDto, tCrowdactionDto);
    });
  });

  test('Testing extension method on List<CommmitmentOption DTO>', () {
    final _requiringCommitmentOption = tCommitmentOptionDto;

    final _testCommitmentOption =
        tCommitmentOptionDto.copyWith(requires: [_requiringCommitmentOption]);
    final List<CommitmentOptionDto> _commitmentDto = [_testCommitmentOption];
    final listOption = _commitmentDto.flatten();
    expect(listOption, [
      _testCommitmentOption,
      _requiringCommitmentOption,
    ]);
  });
}
