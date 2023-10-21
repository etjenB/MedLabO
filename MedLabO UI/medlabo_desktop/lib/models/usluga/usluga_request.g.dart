// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usluga_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UslugaRequest _$UslugaRequestFromJson(Map<String, dynamic> json) =>
    UslugaRequest(
      naziv: json['naziv'] as String?,
      opis: json['opis'] as String?,
      cijena: (json['cijena'] as num?)?.toDouble(),
      trajanjeUMin: json['trajanjeUMin'] as int?,
      rezultatUH: (json['rezultatUH'] as num?)?.toDouble(),
      dostupno: json['dostupno'] as bool?,
      slika: json['slika'] as String?,
      uslugaTestovi: (json['uslugaTestovi'] as List<dynamic>?)
          ?.map((e) => Test.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UslugaRequestToJson(UslugaRequest instance) =>
    <String, dynamic>{
      'naziv': instance.naziv,
      'opis': instance.opis,
      'cijena': instance.cijena,
      'trajanjeUMin': instance.trajanjeUMin,
      'rezultatUH': instance.rezultatUH,
      'dostupno': instance.dostupno,
      'slika': instance.slika,
      'uslugaTestovi': instance.uslugaTestovi,
    };
