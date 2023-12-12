// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacijentUpdateRequest _$PacijentUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    PacijentUpdateRequest(
      id: json['id'] as String?,
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      datumRodjenja: json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      adresa: json['adresa'] as String?,
      spolID: json['spolID'] as int?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$PacijentUpdateRequestToJson(
        PacijentUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'adresa': instance.adresa,
      'spolID': instance.spolID,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
