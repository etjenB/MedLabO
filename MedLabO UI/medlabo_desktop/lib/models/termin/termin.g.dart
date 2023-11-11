// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termin _$TerminFromJson(Map<String, dynamic> json) => Termin(
      terminID: json['terminID'] as String?,
      dtTermina: json['dtTermina'] as String?,
      status: json['status'] as bool?,
      napomena: json['napomena'] as String?,
      odgovor: json['odgovor'] as String?,
      obavljen: json['obavljen'] as bool?,
      rezultatTermina: json['rezultatTermina'] as bool?,
      rezultatTerminaPDF: json['rezultatTerminaPDF'] as String?,
      terminUsluge: (json['terminUsluge'] as List<dynamic>?)
          ?.map((e) => Usluga.fromJson(e as Map<String, dynamic>))
          .toList(),
      terminTestovi: (json['terminTestovi'] as List<dynamic>?)
          ?.map((e) => TerminTest.fromJson(e as Map<String, dynamic>))
          .toList(),
      isDeleted: json['isDeleted'] as bool?,
      pacijent: json['pacijent'] == null
          ? null
          : Pacijent.fromJson(json['pacijent'] as Map<String, dynamic>),
      medicinskoOsoblje: json['medicinskoOsoblje'] == null
          ? null
          : MedicinskoOsoblje.fromJson(
              json['medicinskoOsoblje'] as Map<String, dynamic>),
      racun: json['racun'] == null
          ? null
          : Racun.fromJson(json['racun'] as Map<String, dynamic>),
      zakljucak: json['zakljucak'] == null
          ? null
          : Zakljucak.fromJson(json['zakljucak'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
      'terminID': instance.terminID,
      'dtTermina': instance.dtTermina,
      'status': instance.status,
      'napomena': instance.napomena,
      'odgovor': instance.odgovor,
      'obavljen': instance.obavljen,
      'rezultatTermina': instance.rezultatTermina,
      'rezultatTerminaPDF': instance.rezultatTerminaPDF,
      'terminUsluge': instance.terminUsluge,
      'terminTestovi': instance.terminTestovi,
      'isDeleted': instance.isDeleted,
      'pacijent': instance.pacijent,
      'medicinskoOsoblje': instance.medicinskoOsoblje,
      'racun': instance.racun,
      'zakljucak': instance.zakljucak,
    };
