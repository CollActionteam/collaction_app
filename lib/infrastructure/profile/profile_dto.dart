import 'package:equatable/equatable.dart';

import '../../domain/profile/profile.dart';

class ProfileDto extends Equatable {
    const ProfileDto({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    this.bio,
  });

  Profile toDomain() {
    return Profile(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      bio: bio,
    );
  }

    factory ProfileDto.fromJson(Map<String, dynamic> json) => ProfileDto(
        userId: json['userId'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        avatar: json['avatar'] as String,
        bio: json['bio'] as String?,
      );

    final String userId;

    final String firstName;

    final String lastName;

    final String avatar;

    final String? bio;

    ProfileDto copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? avatar,
    String? Function()? bio,
  }) {
    return ProfileDto(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      bio: bio != null ? bio() : this.bio,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        avatar,
        bio,
      ];

    Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'avatar': avatar,
        'bio': bio,
      };
}
