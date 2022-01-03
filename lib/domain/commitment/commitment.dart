import 'package:freezed_annotation/freezed_annotation.dart';

part 'commitment.freezed.dart';

@freezed
class Commitment with _$Commitment {
  const factory Commitment({
    required int id,
    required String title,
    required String description,
    @Default(false) bool checked,
    String? icon,
  }) = _Commitment;
}
