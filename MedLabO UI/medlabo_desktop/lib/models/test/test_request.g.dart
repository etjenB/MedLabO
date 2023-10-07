// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestRequest _$TestRequestFromJson(Map<String, dynamic> json) => TestRequest(
      naziv: json['naziv'] as String?,
      opis: json['opis'] as String?,
      cijena: (json['cijena'] as num?)?.toDouble(),
      slika: json['slika'] as String?,
      napomenaZaPripremu: json['napomenaZaPripremu'] as String?,
      tipUzorka: json['tipUzorka'] as String?,
      testParametarID: json['testParametarID'] as String?,
    );

Map<String, dynamic> _$TestRequestToJson(TestRequest instance) =>
    <String, dynamic>{
      'naziv': instance.naziv,
      'opis': instance.opis,
      'cijena': instance.cijena,
      'slika': instance.slika,
      'napomenaZaPripremu': instance.napomenaZaPripremu,
      'tipUzorka': instance.tipUzorka,
      'testParametarID': instance.testParametarID,
    };
