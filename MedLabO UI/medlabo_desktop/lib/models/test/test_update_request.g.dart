// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestUpdateRequest _$TestUpdateRequestFromJson(Map<String, dynamic> json) =>
    TestUpdateRequest(
      naziv: json['naziv'] as String?,
      opis: json['opis'] as String?,
      cijena: (json['cijena'] as num?)?.toDouble(),
      slika: json['slika'] as String?,
      napomenaZaPripremu: json['napomenaZaPripremu'] as String?,
      tipUzorka: json['tipUzorka'] as String?,
      testParametarID: json['testParametarID'] as String?,
    );

Map<String, dynamic> _$TestUpdateRequestToJson(TestUpdateRequest instance) =>
    <String, dynamic>{
      'naziv': instance.naziv,
      'opis': instance.opis,
      'cijena': instance.cijena,
      'slika': instance.slika,
      'napomenaZaPripremu': instance.napomenaZaPripremu,
      'tipUzorka': instance.tipUzorka,
      'testParametarID': instance.testParametarID,
    };
