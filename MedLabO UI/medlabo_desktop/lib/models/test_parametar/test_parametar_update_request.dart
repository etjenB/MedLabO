import 'package:json_annotation/json_annotation.dart';

part 'test_parametar_update_request.g.dart';

@JsonSerializable()
class TestParametarUpdateRequest {
  double? minVrijednost;
  double? maxVrijednost;
  String? normalnaVrijednost;
  String? jedinica;

  TestParametarUpdateRequest(
      {this.minVrijednost,
      this.maxVrijednost,
      this.normalnaVrijednost,
      this.jedinica});

  factory TestParametarUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$TestParametarUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TestParametarUpdateRequestToJson(this);
}
