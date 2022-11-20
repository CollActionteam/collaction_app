import 'package:collaction_app/infrastructure/participation/participation_dto.dart';
import 'package:collaction_app/domain/participation/participation.dart';

final tParticipation = Participation(
  id: 'id',
  crowdActionId: 'crowdActionId',
  fullName: 'fullName',
  avatar: 'avatar',
  userId: 'userId',
  commitmentOptions: 'commitmentOptions' as List<String>,
  joinDate: 'joinDate' as DateTime,
  dailyCheckIns: 'dailyCheckIns' as int,
);

final tParticipationDto = ParticipationDto(
  id: 'id',
  crowdActionId: 'crowdActionId',
  fullName: 'fullName',
  avatar: 'avatar',
  userId: 'userId',
  commitmentOptions: 'commitmentOptions' as List<String>,
  joinDate: 'joinDate',
  dailyCheckIns: 'dailyCheckIns' as int,
);

const tParticipationJson = {
  'id': 'id',
  'crowdActionId': 'crowdActionId',
  'fullName': 'fullName',
  'avatar': 'avatar',
  'userId': 'userId',
  'commitmentOptions': 'commitmentOptions',
  'joinDate': 'joinDate',
  'dailyCheckIns': 'dailyCheckIns',
};
