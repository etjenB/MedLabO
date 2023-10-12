// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novost_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NovostRequest _$NovostRequestFromJson(Map<String, dynamic> json) =>
    NovostRequest(
      naslov: json['naslov'] as String?,
      sadrzaj: json['sadrzaj'] as String?,
      slika: json['slika'] as String?,
    );

Map<String, dynamic> _$NovostRequestToJson(NovostRequest instance) =>
    <String, dynamic>{
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'slika': instance.slika,
    };
