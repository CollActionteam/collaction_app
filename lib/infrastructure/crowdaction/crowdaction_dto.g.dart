// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowdaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CrowdActionDto _$_$_CrowdActionDtoFromJson(Map<String, dynamic> json) {
  return _$_CrowdActionDto(
    name: json['name'] as String,
    description: json['description'] as String,
    start: DateTime.parse(json['start'] as String),
    end: DateTime.parse(json['end'] as String),
  );
}

Map<String, dynamic> _$_$_CrowdActionDtoToJson(_$_CrowdActionDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };

_$_CrowdActionList _$_$_CrowdActionListFromJson(Map<String, dynamic> json) {
  return _$_CrowdActionList(
    crowdactions: (json['crowdactions'] as List<dynamic>)
        .map((e) => CrowdActionDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_CrowdActionListToJson(_$_CrowdActionList instance) =>
    <String, dynamic>{
      'crowdactions': instance.crowdactions,
    };
