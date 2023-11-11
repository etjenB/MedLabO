// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezultat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezultat _$RezultatFromJson(Map<String, dynamic> json) => Rezultat(
      json['rezultatID'] as String?,
      json['dtRezultata'] as String?,
      json['testZakljucak'] as String?,
      json['obiljezen'] as bool?,
      (json['rezFlo'] as num?)?.toDouble(),
      json['rezStr'] as String?,
      (json['razlikaOdNormalne'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RezultatToJson(Rezultat instance) => <String, dynamic>{
      'rezultatID': instance.rezultatID,
      'dtRezultata': instance.dtRezultata,
      'testZakljucak': instance.testZakljucak,
      'obiljezen': instance.obiljezen,
      'rezFlo': instance.rezFlo,
      'rezStr': instance.rezStr,
      'razlikaOdNormalne': instance.razlikaOdNormalne,
    };
