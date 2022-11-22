import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';

final tCommitmentOption = CommitmentOption(
  id: 'id',
  type: 'type',
  label: 'label',
  points: 0,
  blocks: ['blocks'],
  description: 'description',
  iconId: 'iconId',
);

final tCommitmentOptionDto = CommitmentOptionDto(
  id: 'id',
  type: 'type',
  label: 'label',
  points: 0,
  blocks: ['blocks'],
  description: 'description',
  icon: 'iconId',
);

final tCommitmentOptionJson = {
  'id': 'id',
  'type': 'type',
  'label': 'label',
  'points': 0,
  'blocks': ['blocks'],
  'description': 'description',
  'icon': 'iconId',
};
