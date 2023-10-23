import 'package:json_annotation/json_annotation.dart';

part 'medicinsko_osoblje_update_request.g.dart';

@JsonSerializable()
class MedicinskoOsobljeUpdateRequest {
  String? id;
  String? ime;
  String? prezime;
  bool? isActive;
  String? spol;
  String? zvanjeID;
  String? userName;
  String? email;
  String? phone;

  MedicinskoOsobljeUpdateRequest(
      {this.ime,
      this.prezime,
      this.isActive,
      this.spol,
      this.zvanjeID,
      this.userName,
      this.email,
      this.phone});

  factory MedicinskoOsobljeUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$MedicinskoOsobljeUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MedicinskoOsobljeUpdateRequestToJson(this);
}
