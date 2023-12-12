// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pacijent _$PacijentFromJson(Map<String, dynamic> json) => Pacijent(
      json['ime'] as String?,
      json['prezime'] as String?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['adresa'] as String?,
      (json['termini'] as List<dynamic>?)
          ?.map((e) => Termin.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['spol'] == null
          ? null
          : Spol.fromJson(json['spol'] as Map<String, dynamic>),
      json['id'] as String?,
      json['userName'] as String?,
      json['email'] as String?,
      json['phoneNumber'] as String?,
    )..spolID = json['spolID'] as int?;

Map<String, dynamic> _$PacijentToJson(Pacijent instance) => <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'adresa': instance.adresa,
      'termini': instance.termini,
      'spolID': instance.spolID,
      'spol': instance.spol,
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
