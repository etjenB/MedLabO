// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pacijent _$PacijentFromJson(Map<String, dynamic> json) => Pacijent(
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      datumRodjenja: json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      adresa: json['adresa'] as String?,
      spol: json['spol'] == null
          ? null
          : Spol.fromJson(json['spol'] as Map<String, dynamic>),
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    )..spolID = json['spolID'] as int?;

Map<String, dynamic> _$PacijentToJson(Pacijent instance) => <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'adresa': instance.adresa,
      'spolID': instance.spolID,
      'spol': instance.spol,
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
