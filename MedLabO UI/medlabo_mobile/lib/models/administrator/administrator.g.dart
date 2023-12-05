// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Administrator _$AdministratorFromJson(Map<String, dynamic> json) =>
    Administrator(
      id: json['id'] as String?,
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      isKontakt: json['isKontakt'] as bool?,
      kontaktInfo: json['kontaktInfo'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$AdministratorToJson(Administrator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'isKontakt': instance.isKontakt,
      'kontaktInfo': instance.kontaktInfo,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
