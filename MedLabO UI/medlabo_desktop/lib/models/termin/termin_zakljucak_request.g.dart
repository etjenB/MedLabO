// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin_zakljucak_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminZakljucak _$TerminZakljucakFromJson(Map<String, dynamic> json) =>
    TerminZakljucak(
      opis: json['opis'] as String?,
      detaljno: json['detaljno'] as String?,
      terminID: json['terminID'] as String?,
    );

Map<String, dynamic> _$TerminZakljucakToJson(TerminZakljucak instance) =>
    <String, dynamic>{
      'opis': instance.opis,
      'detaljno': instance.detaljno,
      'terminID': instance.terminID,
    };
