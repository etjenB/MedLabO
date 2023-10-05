// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_parametar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestParametar _$TestParametarFromJson(Map<String, dynamic> json) =>
    TestParametar(
      testParametarID: json['testParametarID'] as String?,
      minVrijednost: (json['minVrijednost'] as num?)?.toDouble(),
      maxVrijednost: (json['maxVrijednost'] as num?)?.toDouble(),
      normalnaVrijednost: json['normalnaVrijednost'] as String?,
      jedinica: json['jedinica'] as String?,
    );

Map<String, dynamic> _$TestParametarToJson(TestParametar instance) =>
    <String, dynamic>{
      'testParametarID': instance.testParametarID,
      'minVrijednost': instance.minVrijednost,
      'maxVrijednost': instance.maxVrijednost,
      'normalnaVrijednost': instance.normalnaVrijednost,
      'jedinica': instance.jedinica,
    };
