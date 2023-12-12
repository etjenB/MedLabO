import 'package:json_annotation/json_annotation.dart';

part 'pacijent_update_request.g.dart';

@JsonSerializable()
class PacijentUpdateRequest {
  String? id;
  String? ime;
  String? prezime;
  DateTime? datumRodjenja;
  String? adresa;
  int? spolID;
  String? userName;
  String? email;
  String? phoneNumber;

  PacijentUpdateRequest(
      {this.id,
      this.ime,
      this.prezime,
      this.datumRodjenja,
      this.adresa,
      this.spolID,
      this.userName,
      this.email,
      this.phoneNumber});

  factory PacijentUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$PacijentUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PacijentUpdateRequestToJson(this);
}
