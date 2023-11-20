// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezultat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezultat _$RezultatFromJson(Map<String, dynamic> json) => Rezultat(
      rezultatID: json['rezultatID'] as String?,
      dtRezultata: json['dtRezultata'] as String?,
      testZakljucak: json['testZakljucak'] as String?,
      obiljezen: json['obiljezen'] as bool?,
      rezFlo: (json['rezFlo'] as num?)?.toDouble(),
      rezStr: json['rezStr'] as String?,
      razlikaOdNormalne: (json['razlikaOdNormalne'] as num?)?.toDouble(),
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
