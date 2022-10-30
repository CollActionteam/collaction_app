import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_form_dto.freezed.dart';
part 'contact_form_dto.g.dart';

@freezed
class ContactFormDto with _$ContactFormDto {
  const ContactFormDto._();

  factory ContactFormDto({
    required String email,
    @Default('Hello CollAction!') String? subject,
    required String message,
  }) = _ContactFormDto;

  factory ContactFormDto.fromJson(Map<String, dynamic> json) =>
      _$ContactFormDtoFromJson(json);
}
