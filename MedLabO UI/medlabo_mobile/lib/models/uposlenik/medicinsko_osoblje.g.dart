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
      spol: json['spol'] == null
          ? null
          : Spol.fromJson(json['spol'] as Map<String, dynamic>),
      zvanje: json['zvanje'] == null
          ? null
          : Zvanje.fromJson(json['zvanje'] as Map<String, dynamic>),
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$MedicinskoOsobljeToJson(MedicinskoOsoblje instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'isActive': instance.isActive,
      'dtZaposlenja': instance.dtZaposlenja,
      'dtPrekidRadnogOdnosa': instance.dtPrekidRadnogOdnosa,
      'spol': instance.spol,
      'zvanje': instance.zvanje,
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
