import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

@JsonSerializable()
class Test {
  String? testID;
  String? naziv;
  String? opis;
  double? cijena;
  String? slika;
  String? napomenaZaPripremu;
  String? tipUzorka;
  String? dtKreiranja;
  String? administratorID;
  String? testParametarID;
  int? occurrenceCount;

  Test(
      {this.testID,
      this.naziv,
      this.opis,
      this.cijena,
      this.slika,
      this.napomenaZaPripremu,
      this.tipUzorka,
      this.dtKreiranja,
      this.administratorID,
      this.testParametarID,
      this.occurrenceCount});

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

  Map<String, dynamic> toJson() => _$TestToJson(this);
}
