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
          spol: json['spol'] as String?,
          zvanjeID: json['zvanjeID'] as String?,
          userName: json['userName'] as String?,
          password: json['password'] as String?,
          email: json['email'] as String?,
          phone: json['phone'] as String?,
        );

Map<String, dynamic> _$MedicinskoOsobljeRegistrationRequestToJson(
        MedicinskoOsobljeRegistrationRequest instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'isActive': instance.isActive,
      'spol': instance.spol,
      'zvanjeID': instance.zvanjeID,
      'userName': instance.userName,
      'password': instance.password,
      'email': instance.email,
      'phone': instance.phone,
    };
