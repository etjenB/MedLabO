// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicinsko_osoblje_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicinskoOsobljeUpdateRequest _$MedicinskoOsobljeUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    MedicinskoOsobljeUpdateRequest(
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      isActive: json['isActive'] as bool?,
      spolID: json['spolID'] as int?,
      zvanjeID: json['zvanjeID'] as int?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$MedicinskoOsobljeUpdateRequestToJson(
        MedicinskoOsobljeUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'isActive': instance.isActive,
      'spolID': instance.spolID,
      'zvanjeID': instance.zvanjeID,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
