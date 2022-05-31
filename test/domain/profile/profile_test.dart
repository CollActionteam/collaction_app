import 'package:collaction_app/domain/profile/profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('testing Profile DTO', () async {
    const tProfile = Profile(bio: 'test');
    expect(const Profile(bio: 'test'), tProfile);
  });
}
