import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_desktop/models/test/test.dart';

part 'usluga.g.dart';

@JsonSerializable()
class Usluga {
  String? uslugaID;
  String? naziv;
  String? opis;
  double? cijena;
  int? trajanjeUMin;
  double? rezultatUH;
  bool? dostupno;
  String? dtKreiranja;
  String? dtZadnjeModifikacije;
  String? slika;
  List<Test>? uslugaTestovi;
  String? administratorID;

  Usluga(
      {this.uslugaID,
      this.naziv,
      this.opis,
      this.cijena,
      this.trajanjeUMin,
      this.rezultatUH,
      this.dostupno,
      this.dtKreiranja,
      this.dtZadnjeModifikacije,
      this.slika,
      this.uslugaTestovi,
      this.administratorID});

  factory Usluga.fromJson(Map<String, dynamic> json) => _$UslugaFromJson(json);

  Map<String, dynamic> toJson() => _$UslugaToJson(this);
}
