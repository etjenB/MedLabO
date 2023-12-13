// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      testID: json['testID'] as String?,
      naziv: json['naziv'] as String?,
      opis: json['opis'] as String?,
      cijena: (json['cijena'] as num?)?.toDouble(),
      slika: json['slika'] as String?,
      napomenaZaPripremu: json['napomenaZaPripremu'] as String?,
      tipUzorka: json['tipUzorka'] as String?,
      dtKreiranja: json['dtKreiranja'] as String?,
      administratorID: json['administratorID'] as String?,
      testParametarID: json['testParametarID'] as String?,
      occurrenceCount: json['occurrenceCount'] as int?,
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'testID': instance.testID,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'cijena': instance.cijena,
      'slika': instance.slika,
      'napomenaZaPripremu': instance.napomenaZaPripremu,
      'tipUzorka': instance.tipUzorka,
      'dtKreiranja': instance.dtKreiranja,
      'administratorID': instance.administratorID,
      'testParametarID': instance.testParametarID,
      'occurrenceCount': instance.occurrenceCount,
    };
