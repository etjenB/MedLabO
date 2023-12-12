import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_desktop/models/spol/spol.dart';
import 'package:medlabo_desktop/models/termin/termin.dart';

part 'pacijent.g.dart';

@JsonSerializable()
class Pacijent {
  String? ime;
  String? prezime;
  DateTime? datumRodjenja;
  String? adresa;
  List<Termin>? termini;
  int? spolID;
  Spol? spol;
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;

  Pacijent(
    this.ime,
    this.prezime,
    this.datumRodjenja,
    this.adresa,
    this.termini,
    this.spol,
    this.id,
    this.userName,
    this.email,
    this.phoneNumber,
  );

  factory Pacijent.fromJson(Map<String, dynamic> json) =>
      _$PacijentFromJson(json);

  Map<String, dynamic> toJson() => _$PacijentToJson(this);
}
