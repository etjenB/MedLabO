// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavijest_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObavijestRequest _$ObavijestRequestFromJson(Map<String, dynamic> json) =>
    ObavijestRequest(
      naslov: json['naslov'] as String?,
      sadrzaj: json['sadrzaj'] as String?,
      slika: json['slika'] as String?,
    );

Map<String, dynamic> _$ObavijestRequestToJson(ObavijestRequest instance) =>
    <String, dynamic>{
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'slika': instance.slika,
    };
