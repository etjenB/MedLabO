import 'package:json_annotation/json_annotation.dart';

part 'medicinsko_osoblje_registration_request.g.dart';

@JsonSerializable()
class MedicinskoOsobljeRegistrationRequest {
  String? ime;
  String? prezime;
  bool? isActive;
  int? spolID;
  int? zvanjeID;
  String? userName;
  String? password;
  String? email;
  String? phoneNumber;

  MedicinskoOsobljeRegistrationRequest(
      {this.ime,
      this.prezime,
      this.isActive,
      this.spolID,
      this.zvanjeID,
      this.userName,
      this.password,
      this.email,
      this.phoneNumber});

  factory MedicinskoOsobljeRegistrationRequest.fromJson(
          Map<String, dynamic> json) =>
      _$MedicinskoOsobljeRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MedicinskoOsobljeRegistrationRequestToJson(this);
}
