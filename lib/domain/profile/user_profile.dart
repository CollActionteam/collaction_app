import 'package:equatable/equatable.dart';

import '../../core/core.dart';
import '../user/user.dart';
import 'profile.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.user,
    required this.profile,
  });

  final User user;

  final Profile profile;

  UserProfile copyWith({
    User? user,
    Profile? profile,
  }) {
    return UserProfile(
      user: user ?? this.user,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
        user,
        profile,
      ];

  // User profile avatar url
  String? get avatarUrl => '$baseStaticUrl/${profile.avatar}';
}
