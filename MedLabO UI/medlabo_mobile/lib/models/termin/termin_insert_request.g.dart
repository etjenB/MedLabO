// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminInsertRequest _$TerminInsertRequestFromJson(Map<String, dynamic> json) =>
    TerminInsertRequest(
      dtTermina: json['dtTermina'] as String?,
      napomena: json['napomena'] as String?,
      usluge:
          (json['usluge'] as List<dynamic>?)?.map((e) => e as String).toList(),
      testovi:
          (json['testovi'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TerminInsertRequestToJson(
        TerminInsertRequest instance) =>
    <String, dynamic>{
      'dtTermina': instance.dtTermina,
      'napomena': instance.napomena,
      'usluge': instance.usluge,
      'testovi': instance.testovi,
    };
