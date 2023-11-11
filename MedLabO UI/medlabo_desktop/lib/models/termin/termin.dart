import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_desktop/models/pacijent/pacijent.dart';
import 'package:medlabo_desktop/models/racun/racun.dart';
import 'package:medlabo_desktop/models/termin_test/termin_test.dart';
import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje.dart';
import 'package:medlabo_desktop/models/usluga/usluga.dart';
import 'package:medlabo_desktop/models/zakljucak/zakljucak.dart';

part 'termin.g.dart';

@JsonSerializable()
class Termin {
  String? terminID;
  String? dtTermina;
  bool? status;
  String? napomena;
  String? odgovor;
  bool? obavljen;
  bool? rezultatTermina;
  String? rezultatTerminaPDF;
  List<Usluga>? terminUsluge;
  List<TerminTest>? terminTestovi;
  bool? isDeleted;
  Pacijent? pacijent;
  MedicinskoOsoblje? medicinskoOsoblje;
  Racun? racun;
  Zakljucak? zakljucak;

  Termin(
      {this.terminID,
      this.dtTermina,
      this.status,
      this.napomena,
      this.odgovor,
      this.obavljen,
      this.rezultatTermina,
      this.rezultatTerminaPDF,
      this.terminUsluge,
      this.terminTestovi,
      this.isDeleted,
      this.pacijent,
      this.medicinskoOsoblje,
      this.racun,
      this.zakljucak});

  factory Termin.fromJson(Map<String, dynamic> json) => _$TerminFromJson(json);

  Map<String, dynamic> toJson() => _$TerminToJson(this);
}
