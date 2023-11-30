// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zakljucak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zakljucak _$ZakljucakFromJson(Map<String, dynamic> json) => Zakljucak(
      json['opis'] as String?,
      json['detaljno'] as String?,
      json['termin'] == null
          ? null
          : Termin.fromJson(json['termin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZakljucakToJson(Zakljucak instance) => <String, dynamic>{
      'opis': instance.opis,
      'detaljno': instance.detaljno,
      'termin': instance.termin,
    };
