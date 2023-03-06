import 'package:equatable/equatable.dart';

import '../user/user.dart';
import 'profile.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.user,
    required this.profile,
  });

  // factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
  //       user: BaseUser.fromJson(json['user'] as Map<String, dynamic>),
  //       profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
  //     );

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

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'user': user.toJson(),
  //       'profile': profile.toJson(),
  //     };
}
