// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zvanje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zvanje _$ZvanjeFromJson(Map<String, dynamic> json) => Zvanje(
      zvanjeID: json['zvanjeID'] as int?,
      naziv: json['naziv'] as String?,
      opis: json['opis'] as String?,
    );

Map<String, dynamic> _$ZvanjeToJson(Zvanje instance) => <String, dynamic>{
      'zvanjeID': instance.zvanjeID,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
