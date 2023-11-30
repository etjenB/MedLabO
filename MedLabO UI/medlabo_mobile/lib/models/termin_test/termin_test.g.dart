// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminTest _$TerminTestFromJson(Map<String, dynamic> json) => TerminTest(
      json['terminID'] as String?,
      json['testID'] as String?,
      json['test'] == null
          ? null
          : Test.fromJson(json['test'] as Map<String, dynamic>),
      json['rezultatID'] as String?,
      json['rezultat'] == null
          ? null
          : Rezultat.fromJson(json['rezultat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerminTestToJson(TerminTest instance) =>
    <String, dynamic>{
      'terminID': instance.terminID,
      'testID': instance.testID,
      'test': instance.test,
      'rezultatID': instance.rezultatID,
      'rezultat': instance.rezultat,
    };
