import 'package:json_annotation/json_annotation.dart';

part 'usluga_request.g.dart';

@JsonSerializable()
class UslugaRequest {
  String? naziv;
  String? opis;
  double? cijena;
  int? trajanjeUMin;
  double? rezultatUH;
  bool? dostupno;
  String? slika;
  List<String>? testovi;

  UslugaRequest(
      {this.naziv,
      this.opis,
      this.cijena,
      this.trajanjeUMin,
      this.rezultatUH,
      this.dostupno,
      this.slika,
      this.testovi});

  factory UslugaRequest.fromJson(Map<String, dynamic> json) =>
      _$UslugaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UslugaRequestToJson(this);
}
