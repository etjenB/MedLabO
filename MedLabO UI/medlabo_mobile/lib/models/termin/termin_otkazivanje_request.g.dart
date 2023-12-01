// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin_otkazivanje_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminOtkazivanjeRequest _$TerminOtkazivanjeRequestFromJson(
        Map<String, dynamic> json) =>
    TerminOtkazivanjeRequest(
      terminID: json['terminID'] as String?,
      razlogOtkazivanja: json['razlogOtkazivanja'] as String?,
    );

Map<String, dynamic> _$TerminOtkazivanjeRequestToJson(
        TerminOtkazivanjeRequest instance) =>
    <String, dynamic>{
      'terminID': instance.terminID,
      'razlogOtkazivanja': instance.razlogOtkazivanja,
    };
