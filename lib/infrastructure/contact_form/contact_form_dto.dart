import 'package:equatable/equatable.dart';

class ContactFormDto extends Equatable {
  const ContactFormDto({
    required this.email,
    this.subject = 'Hello CollAction!',
    required this.message,
  });

  factory ContactFormDto.fromJson(Map<String, dynamic> json) => ContactFormDto(
        email: json['email'] as String,
        subject: json['subject'] as String?,
        message: json['message'] as String,
      );

  final String email;

  final String? subject;

  final String message;

  ContactFormDto copyWith({
    String? email,
    String? Function()? subject,
    String? message,
  }) {
    return ContactFormDto(
      email: email ?? this.email,
      subject: subject != null ? subject() : this.subject,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        email,
        subject,
        message,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'subject': subject,
        'message': message,
      };
}
