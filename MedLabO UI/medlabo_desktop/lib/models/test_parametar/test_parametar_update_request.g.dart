// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_parametar_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestParametarUpdateRequest _$TestParametarUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    TestParametarUpdateRequest(
      minVrijednost: (json['minVrijednost'] as num?)?.toDouble(),
      maxVrijednost: (json['maxVrijednost'] as num?)?.toDouble(),
      normalnaVrijednost: json['normalnaVrijednost'] as String?,
      jedinica: json['jedinica'] as String?,
    );

Map<String, dynamic> _$TestParametarUpdateRequestToJson(
        TestParametarUpdateRequest instance) =>
    <String, dynamic>{
      'minVrijednost': instance.minVrijednost,
      'maxVrijednost': instance.maxVrijednost,
      'normalnaVrijednost': instance.normalnaVrijednost,
      'jedinica': instance.jedinica,
    };
