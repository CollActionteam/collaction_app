import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import 'crowdaction_fixture.dart';

void main() {
  group('Tests for CrowdactionDTO:', () {
    test('Text .fromJson()', () {
      expect(
        CrowdActionDto.fromJson(cCrowdActionPasswordJson),
        cCrowdActionPasswordDto,
      );
      expect(
        CrowdActionDto.fromJson(cCrowdActionNoPasswordJson),
        cCrowdActionNoPasswordDto,
      );
    });

    test('Test .toDomain()', () {
      expect(cCrowdActionPasswordDto.toDomain(), cCrowdActionPassword);
      expect(cCrowdActionNoPasswordDto.toDomain(), cCrowdActionNoPassword);
    });
  });

  group('Tests for ImagesDTO:', () {
    test('Test .fromJson()', () {
      expect(
        ImagesDto.fromJson(cImagesJson),
        cImagesDto,
      );
    });

    test('Test .toDomain()', () {
      expect(cImagesDto.toDomain(), cImages);
    });
  });

  group('Tests for CommitmentOptionDTO:', () {
    test('Test .fromJson()', () {
      expect(
        CommitmentOptionDto.fromJson(cCommitmentOptionJson),
        cCommitmentOptionDto,
      );
    });

    test('Test .toDomain()', () {
      expect(cCommitmentOptionDto.toDomain(), cCommitmentOption);
    });
  });

  group('Tests for TopParticipantDto:', () {
    test('Test .fromJson()', () {
      expect(
        TopParticipantDto.fromJson(cTopParticipantOneJson),
        cTopParticipantOneDto,
      );

      expect(
        TopParticipantDto.fromJson(cTopParticipantTwoJson),
        cTopParticipantTwoDto,
      );

      expect(
        TopParticipantDto.fromJson(cTopParticipantThreeJson),
        cTopParticipantThreeDto,
      );

      expect(
        TopParticipantDto.fromJson(cTopParticipantFourJson),
        cTopParticipantFourDto,
      );
    });

    test('Test .toDomain()', () {
      expect(cTopParticipantOneDto.toDomain(), cTopParticipantOne);
      expect(cTopParticipantTwoDto.toDomain(), cTopParticipantTwo);
      expect(cTopParticipantThreeDto.toDomain(), cTopParticipantThree);
      expect(cTopParticipantFourDto.toDomain(), cTopParticipantFour);
    });
  });
}
