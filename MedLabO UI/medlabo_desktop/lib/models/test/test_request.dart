import 'package:json_annotation/json_annotation.dart';

part 'test_request.g.dart';

@JsonSerializable()
class TestRequest {
  String? naziv;
  String? opis;
  double? cijena;
  String? slika;
  String? napomenaZaPripremu;
  String? tipUzorka;
  String? testParametarID;

  TestRequest(
      {this.naziv,
      this.opis,
      this.cijena,
      this.slika,
      this.napomenaZaPripremu,
      this.tipUzorka,
      this.testParametarID});

  factory TestRequest.fromJson(Map<String, dynamic> json) =>
      _$TestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TestRequestToJson(this);
}
