import 'package:json_annotation/json_annotation.dart';

part 'test_update_request.g.dart';

@JsonSerializable()
class TestUpdateRequest {
  String? naziv;
  String? opis;
  double? cijena;
  String? slika;
  String? napomenaZaPripremu;
  String? tipUzorka;
  String? testParametarID;

  TestUpdateRequest(
      {this.naziv,
      this.opis,
      this.cijena,
      this.slika,
      this.napomenaZaPripremu,
      this.tipUzorka,
      this.testParametarID});

  factory TestUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$TestUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TestUpdateRequestToJson(this);
}
