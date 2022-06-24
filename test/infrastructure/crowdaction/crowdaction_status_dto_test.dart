import 'package:collaction_app/infrastructure/crowdaction/crowdaction_status_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../infrastructure_fixtures.dart';

void main() {
  test('Testing factory CrowdactionStatusDto', () {
    final _crowdactionStatusSto =
        CrowdActionStatusDto.fromJson(tCrowdactionStatusJson);
    expect(_crowdactionStatusSto, tCrowdactionStatusDto);
  });
}
