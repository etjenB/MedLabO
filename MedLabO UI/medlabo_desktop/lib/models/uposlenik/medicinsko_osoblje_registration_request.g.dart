// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicinsko_osoblje_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicinskoOsobljeRegistrationRequest
    _$MedicinskoOsobljeRegistrationRequestFromJson(Map<String, dynamic> json) =>
        MedicinskoOsobljeRegistrationRequest(
          ime: json['ime'] as String?,
          prezime: json['prezime'] as String?,
          isActive: json['isActive'] as bool?,
          spolID: json['spolID'] as int?,
          zvanjeID: json['zvanjeID'] as int?,
          userName: json['userName'] as String?,
          password: json['password'] as String?,
          email: json['email'] as String?,
          phoneNumber: json['phoneNumber'] as String?,
        );

Map<String, dynamic> _$MedicinskoOsobljeRegistrationRequestToJson(
        MedicinskoOsobljeRegistrationRequest instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'isActive': instance.isActive,
      'spolID': instance.spolID,
      'zvanjeID': instance.zvanjeID,
      'userName': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
