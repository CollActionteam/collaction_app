import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';

final tCommitment = Commitment(
  id: 'id',
  label: 'label',
  points: 0,
  blocks: ['blocks'],
  description: 'description',
  iconId: 'iconId',
);

final tCommitmentDto = CommitmentDto(
  id: 'id',
  label: 'label',
  points: 0,
  blocks: ['blocks'],
  description: 'description',
  icon: 'iconId',
);

final tCommitmentJson = {
  'id': 'id',
  'label': 'label',
  'points': 0,
  'blocks': ['blocks'],
  'description': 'description',
  'icon': 'iconId',
};
