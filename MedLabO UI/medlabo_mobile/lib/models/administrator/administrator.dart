import 'package:json_annotation/json_annotation.dart';

part 'administrator.g.dart';

@JsonSerializable()
class Administrator {
  String? id;
  String? ime;
  String? prezime;
  bool? isKontakt;
  String? kontaktInfo;
  String? userName;
  String? email;
  String? phoneNumber;

  Administrator(
      {this.id,
      this.ime,
      this.prezime,
      this.isKontakt,
      this.kontaktInfo,
      this.userName,
      this.email,
      this.phoneNumber});

  factory Administrator.fromJson(Map<String, dynamic> json) =>
      _$AdministratorFromJson(json);

  Map<String, dynamic> toJson() => _$AdministratorToJson(this);
}
