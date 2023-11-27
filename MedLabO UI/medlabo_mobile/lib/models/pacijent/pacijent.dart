import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_mobile/models/spol/spol.dart';

part 'pacijent.g.dart';

@JsonSerializable()
class Pacijent {
  String? ime;
  String? prezime;
  String? datumRodjenja;
  String? adresa;
  Spol? spol;
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;

  Pacijent(
      {this.ime,
      this.prezime,
      this.datumRodjenja,
      this.adresa,
      this.spol,
      this.id,
      this.userName,
      this.email,
      this.phoneNumber});

  factory Pacijent.fromJson(Map<String, dynamic> json) =>
      _$PacijentFromJson(json);

  Map<String, dynamic> toJson() => _$PacijentToJson(this);
}
