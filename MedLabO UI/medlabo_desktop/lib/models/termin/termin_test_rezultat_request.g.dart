// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin_test_rezultat_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminTestRezultat _$TerminTestRezultatFromJson(Map<String, dynamic> json) =>
    TerminTestRezultat(
      terminID: json['terminID'] as String?,
      testIDs:
          (json['testIDs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rezultati: (json['rezultati'] as List<dynamic>?)
          ?.map((e) => Rezultat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TerminTestRezultatToJson(TerminTestRezultat instance) =>
    <String, dynamic>{
      'terminID': instance.terminID,
      'testIDs': instance.testIDs,
      'rezultati': instance.rezultati,
    };
