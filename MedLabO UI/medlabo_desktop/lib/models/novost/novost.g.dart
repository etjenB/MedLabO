// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Novost _$NovostFromJson(Map<String, dynamic> json) => Novost(
      novostID: json['novostID'] as String?,
      naslov: json['naslov'] as String?,
      sadrzaj: json['sadrzaj'] as String?,
      dtKreiranja: json['dtKreiranja'] as String?,
      dtZadnjeModifikacije: json['dtZadnjeModifikacije'] as String?,
      slika: json['slika'] as String?,
      administratorID: json['administratorID'] as String?,
    );

Map<String, dynamic> _$NovostToJson(Novost instance) => <String, dynamic>{
      'novostID': instance.novostID,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'dtKreiranja': instance.dtKreiranja,
      'dtZadnjeModifikacije': instance.dtZadnjeModifikacije,
      'slika': instance.slika,
      'administratorID': instance.administratorID,
    };
