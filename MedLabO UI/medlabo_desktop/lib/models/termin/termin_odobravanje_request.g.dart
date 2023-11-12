// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin_odobravanje_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminOdobravanjeRequest _$TerminOdobravanjeRequestFromJson(
        Map<String, dynamic> json) =>
    TerminOdobravanjeRequest(
      terminID: json['terminID'] as String?,
      odgovor: json['odgovor'] as String?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$TerminOdobravanjeRequestToJson(
        TerminOdobravanjeRequest instance) =>
    <String, dynamic>{
      'terminID': instance.terminID,
      'odgovor': instance.odgovor,
      'status': instance.status,
    };
