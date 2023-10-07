// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_parametar_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestParametarRequest _$TestParametarRequestFromJson(
        Map<String, dynamic> json) =>
    TestParametarRequest(
      minVrijednost: (json['minVrijednost'] as num?)?.toDouble(),
      maxVrijednost: (json['maxVrijednost'] as num?)?.toDouble(),
      normalnaVrijednost: json['normalnaVrijednost'] as String?,
      jedinica: json['jedinica'] as String?,
    );

Map<String, dynamic> _$TestParametarRequestToJson(
        TestParametarRequest instance) =>
    <String, dynamic>{
      'minVrijednost': instance.minVrijednost,
      'maxVrijednost': instance.maxVrijednost,
      'normalnaVrijednost': instance.normalnaVrijednost,
      'jedinica': instance.jedinica,
    };
