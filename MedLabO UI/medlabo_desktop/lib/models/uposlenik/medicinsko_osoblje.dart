import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_desktop/models/spol/spol.dart';
import 'package:medlabo_desktop/models/zvanje/zvanje.dart';

part 'medicinsko_osoblje.g.dart';

@JsonSerializable()
class MedicinskoOsoblje {
  String? ime;
  String? prezime;
  bool? isActive;
  String? dtZaposlenja;
  String? dtPrekidRadnogOdnosa;
  Spol? spol;
  Zvanje? zvanje;
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;

  MedicinskoOsoblje(
      {this.ime,
      this.prezime,
      this.isActive,
      this.dtZaposlenja,
      this.dtPrekidRadnogOdnosa,
      this.spol,
      this.zvanje,
      this.id,
      this.userName,
      this.email,
      this.phoneNumber});

  factory MedicinskoOsoblje.fromJson(Map<String, dynamic> json) =>
      _$MedicinskoOsobljeFromJson(json);

  Map<String, dynamic> toJson() => _$MedicinskoOsobljeToJson(this);
}
