// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicinsko_osoblje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicinskoOsoblje _$MedicinskoOsobljeFromJson(Map<String, dynamic> json) =>
    MedicinskoOsoblje(
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      isActive: json['isActive'] as bool?,
      dtZaposlenja: json['dtZaposlenja'] as String?,
      dtPrekidRadnogOdnosa: json['dtPrekidRadnogOdnosa'] as String?,
      spol: json['spol'] as String?,
      zvanjeID: json['zvanjeID'] as String?,
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$MedicinskoOsobljeToJson(MedicinskoOsoblje instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'isActive': instance.isActive,
      'dtZaposlenja': instance.dtZaposlenja,
      'dtPrekidRadnogOdnosa': instance.dtPrekidRadnogOdnosa,
      'spol': instance.spol,
      'zvanjeID': instance.zvanjeID,
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'phone': instance.phone,
    };
