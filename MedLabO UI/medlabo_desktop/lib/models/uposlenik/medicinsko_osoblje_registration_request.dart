import 'package:json_annotation/json_annotation.dart';

part 'medicinsko_osoblje_registration_request.g.dart';

@JsonSerializable()
class MedicinskoOsobljeRegistrationRequest {
  String? ime;
  String? prezime;
  bool? isActive;
  String? spol;
  String? zvanjeID;
  String? userName;
  String? password;
  String? email;
  String? phone;

  MedicinskoOsobljeRegistrationRequest(
      {this.ime,
      this.prezime,
      this.isActive,
      this.spol,
      this.zvanjeID,
      this.userName,
      this.password,
      this.email,
      this.phone});

  factory MedicinskoOsobljeRegistrationRequest.fromJson(
          Map<String, dynamic> json) =>
      _$MedicinskoOsobljeRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MedicinskoOsobljeRegistrationRequestToJson(this);
}
