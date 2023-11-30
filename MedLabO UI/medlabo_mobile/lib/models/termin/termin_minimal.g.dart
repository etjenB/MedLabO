// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin_minimal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminMinimal _$TerminMinimalFromJson(Map<String, dynamic> json) =>
    TerminMinimal(
      terminID: json['terminID'] as String?,
      dtTermina: json['dtTermina'] == null
          ? null
          : DateTime.parse(json['dtTermina'] as String),
    );

Map<String, dynamic> _$TerminMinimalToJson(TerminMinimal instance) =>
    <String, dynamic>{
      'terminID': instance.terminID,
      'dtTermina': instance.dtTermina?.toIso8601String(),
    };
