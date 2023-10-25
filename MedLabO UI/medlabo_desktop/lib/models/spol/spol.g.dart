// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spol _$SpolFromJson(Map<String, dynamic> json) => Spol(
      spolID: json['spolID'] as int?,
      kod: json['kod'] as String?,
      naziv: json['naziv'] as String?,
    );

Map<String, dynamic> _$SpolToJson(Spol instance) => <String, dynamic>{
      'spolID': instance.spolID,
      'kod': instance.kod,
      'naziv': instance.naziv,
    };
