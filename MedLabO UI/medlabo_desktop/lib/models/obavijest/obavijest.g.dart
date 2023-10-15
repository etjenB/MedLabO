// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavijest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obavijest _$ObavijestFromJson(Map<String, dynamic> json) => Obavijest(
      obavijestID: json['obavijestID'] as String?,
      naslov: json['naslov'] as String?,
      sadrzaj: json['sadrzaj'] as String?,
      dtKreiranja: json['dtKreiranja'] as String?,
      dtZadnjeModifikacije: json['dtZadnjeModifikacije'] as String?,
      slika: json['slika'] as String?,
      administratorID: json['administratorID'] as String?,
    );

Map<String, dynamic> _$ObavijestToJson(Obavijest instance) => <String, dynamic>{
      'obavijestID': instance.obavijestID,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'dtKreiranja': instance.dtKreiranja,
      'dtZadnjeModifikacije': instance.dtZadnjeModifikacije,
      'slika': instance.slika,
      'administratorID': instance.administratorID,
    };
