// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'racun.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Racun _$RacunFromJson(Map<String, dynamic> json) => Racun(
      (json['cijena'] as num?)?.toDouble(),
      json['placeno'] as bool?,
      json['termin'] == null
          ? null
          : Termin.fromJson(json['termin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RacunToJson(Racun instance) => <String, dynamic>{
      'cijena': instance.cijena,
      'placeno': instance.placeno,
      'termin': instance.termin,
    };
