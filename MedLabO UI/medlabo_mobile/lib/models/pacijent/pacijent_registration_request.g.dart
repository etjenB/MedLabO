// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacijentRegistrationRequest _$PacijentRegistrationRequestFromJson(
        Map<String, dynamic> json) =>
    PacijentRegistrationRequest(
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      datumRodjenja: json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      adresa: json['adresa'] as String?,
      spolID: json['spolID'] as int?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$PacijentRegistrationRequestToJson(
        PacijentRegistrationRequest instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'adresa': instance.adresa,
      'spolID': instance.spolID,
      'userName': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
