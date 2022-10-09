import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';

const imagesDtoJson = {
  'card': 'crowdaction-test/123.png',
  'banner': 'crowdaction-test/456.png'
};

final imagesDtoFromJson = ImagesDto(
  card: 'crowdaction-test/123.png',
  banner: 'crowdaction-test/456.png',
);

const imagesFromJson = Images(
  card: 'crowdaction-test/123.png',
  banner: 'crowdaction-test/456.png',
);
