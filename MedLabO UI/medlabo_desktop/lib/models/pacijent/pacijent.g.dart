// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pacijent _$PacijentFromJson(Map<String, dynamic> json) => Pacijent(
      json['ime'] as String?,
      json['prezime'] as String?,
      json['datumRodjenja'] as String?,
      json['adresa'] as String?,
      (json['termini'] as List<dynamic>?)
          ?.map((e) => Termin.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['spol'] == null
          ? null
          : Spol.fromJson(json['spol'] as Map<String, dynamic>),
      json['userName'] as String?,
      json['email'] as String?,
      json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$PacijentToJson(Pacijent instance) => <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja,
      'adresa': instance.adresa,
      'termini': instance.termini,
      'spol': instance.spol,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
