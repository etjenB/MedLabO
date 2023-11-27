// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usluga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usluga _$UslugaFromJson(Map<String, dynamic> json) => Usluga(
      uslugaID: json['uslugaID'] as String?,
      naziv: json['naziv'] as String?,
      opis: json['opis'] as String?,
      cijena: (json['cijena'] as num?)?.toDouble(),
      trajanjeUMin: json['trajanjeUMin'] as int?,
      rezultatUH: (json['rezultatUH'] as num?)?.toDouble(),
      dostupno: json['dostupno'] as bool?,
      dtKreiranja: json['dtKreiranja'] as String?,
      dtZadnjeModifikacije: json['dtZadnjeModifikacije'] as String?,
      slika: json['slika'] as String?,
      uslugaTestovi: (json['uslugaTestovi'] as List<dynamic>?)
          ?.map((e) => Test.fromJson(e as Map<String, dynamic>))
          .toList(),
      administratorID: json['administratorID'] as String?,
    );

Map<String, dynamic> _$UslugaToJson(Usluga instance) => <String, dynamic>{
      'uslugaID': instance.uslugaID,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'cijena': instance.cijena,
      'trajanjeUMin': instance.trajanjeUMin,
      'rezultatUH': instance.rezultatUH,
      'dostupno': instance.dostupno,
      'dtKreiranja': instance.dtKreiranja,
      'dtZadnjeModifikacije': instance.dtZadnjeModifikacije,
      'slika': instance.slika,
      'uslugaTestovi': instance.uslugaTestovi,
      'administratorID': instance.administratorID,
    };
