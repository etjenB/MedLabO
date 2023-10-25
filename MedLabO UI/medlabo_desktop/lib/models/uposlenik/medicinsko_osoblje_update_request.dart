import 'package:json_annotation/json_annotation.dart';

part 'medicinsko_osoblje_update_request.g.dart';

@JsonSerializable()
class MedicinskoOsobljeUpdateRequest {
  String? id;
  String? ime;
  String? prezime;
  bool? isActive;
  int? spolID;
  int? zvanjeID;
  String? userName;
  String? email;
  String? phoneNumber;

  MedicinskoOsobljeUpdateRequest(
      {this.ime,
      this.prezime,
      this.isActive,
      this.spolID,
      this.zvanjeID,
      this.userName,
      this.email,
      this.phoneNumber});

  factory MedicinskoOsobljeUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$MedicinskoOsobljeUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MedicinskoOsobljeUpdateRequestToJson(this);
}
