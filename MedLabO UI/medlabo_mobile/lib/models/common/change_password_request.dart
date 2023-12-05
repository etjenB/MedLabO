import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  String? userId;
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordRequest(
      {this.userId,
      this.oldPassword,
      this.newPassword,
      this.confirmNewPassword});

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
