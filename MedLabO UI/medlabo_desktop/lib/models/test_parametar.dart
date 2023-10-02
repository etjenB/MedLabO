import 'package:json_annotation/json_annotation.dart';

part 'test_parametar.g.dart';

@JsonSerializable()
class TestParametar {
  String? testParametarID;
  double? minVrijednost;
  double? maxVrijednost;
  String? normalnaVrijednost;
  String? jedinica;

  TestParametar(
      {this.testParametarID,
      this.minVrijednost,
      this.maxVrijednost,
      this.normalnaVrijednost,
      this.jedinica});

  factory TestParametar.fromJson(Map<String, dynamic> json) =>
      _$TestParametarFromJson(json);

  Map<String, dynamic> toJson() => _$TestParametarToJson(this);
}
