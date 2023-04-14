import 'package:collaction_app/infrastructure/participation/participation_dto.dart';
import 'package:collaction_app/domain/participation/participation.dart';

final tParticipation = Participation(
  id: 'id',
  crowdActionId: 'crowdActionId',
  fullName: 'fullName',
  avatar: 'avatar',
  userId: 'userId',
  commitmentOptions: ['commitmentOptions'],
  joinDate: DateTime.parse('20221120'),
  dailyCheckIns: 0,
);

final tParticipationDto = ParticipationDto(
  id: 'id',
  crowdActionId: 'crowdActionId',
  fullName: 'fullName',
  avatar: 'avatar',
  userId: 'userId',
  commitmentOptions: ['commitmentOptions'],
  joinDate: '20221120',
  dailyCheckIns: 0,
);

const tParticipationJson = {
  'id': 'id',
  'crowdActionId': 'crowdActionId',
  'fullName': 'fullName',
  'avatar': 'avatar',
  'userId': 'userId',
  'commitmentOptions': ['commitmentOptions'],
  'joinDate': '20221120',
  'dailyCheckIns': 0,
};
