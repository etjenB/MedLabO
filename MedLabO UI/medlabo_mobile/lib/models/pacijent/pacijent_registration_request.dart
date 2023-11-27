import 'package:json_annotation/json_annotation.dart';

part 'pacijent_registration_request.g.dart';

@JsonSerializable()
class PacijentRegistrationRequest {
  String? ime;
  String? prezime;
  String? datumRodjena;
  String? adresa;
  int? spolID;
  String? userName;
  String? password;
  String? email;
  String? phoneNumber;

  PacijentRegistrationRequest(
      {this.ime,
      this.prezime,
      this.datumRodjena,
      this.adresa,
      this.spolID,
      this.userName,
      this.password,
      this.email,
      this.phoneNumber});

  factory PacijentRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$PacijentRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PacijentRegistrationRequestToJson(this);
}
