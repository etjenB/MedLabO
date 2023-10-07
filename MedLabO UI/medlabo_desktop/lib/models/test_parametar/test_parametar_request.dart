import 'package:json_annotation/json_annotation.dart';

part 'test_parametar_request.g.dart';

@JsonSerializable()
class TestParametarRequest {
  double? minVrijednost;
  double? maxVrijednost;
  String? normalnaVrijednost;
  String? jedinica;

  TestParametarRequest(
      {this.minVrijednost,
      this.maxVrijednost,
      this.normalnaVrijednost,
      this.jedinica});

  factory TestParametarRequest.fromJson(Map<String, dynamic> json) =>
      _$TestParametarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TestParametarRequestToJson(this);
}
