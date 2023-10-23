import 'package:json_annotation/json_annotation.dart';

part 'medicinsko_osoblje.g.dart';

@JsonSerializable()
class MedicinskoOsoblje {
  String? ime;
  String? prezime;
  bool? isActive;
  String? dtZaposlenja;
  String? dtPrekidRadnogOdnosa;
  String? spol;
  String? zvanjeID;
  String? id;
  String? userName;
  String? email;
  String? phone;

  MedicinskoOsoblje(
      {this.ime,
      this.prezime,
      this.isActive,
      this.dtZaposlenja,
      this.dtPrekidRadnogOdnosa,
      this.spol,
      this.zvanjeID,
      this.id,
      this.userName,
      this.email,
      this.phone});

  factory MedicinskoOsoblje.fromJson(Map<String, dynamic> json) =>
      _$MedicinskoOsobljeFromJson(json);

  Map<String, dynamic> toJson() => _$MedicinskoOsobljeToJson(this);
}
