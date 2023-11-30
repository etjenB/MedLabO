import 'package:json_annotation/json_annotation.dart';

part 'rezultat.g.dart';

@JsonSerializable()
class Rezultat {
  String? rezultatID;
  String? dtRezultata;
  String? testZakljucak;
  bool? obiljezen;
  double? rezFlo;
  String? rezStr;
  double? razlikaOdNormalne;

  Rezultat({
    this.rezultatID,
    this.dtRezultata,
    this.testZakljucak,
    this.obiljezen,
    this.rezFlo,
    this.rezStr,
    this.razlikaOdNormalne,
  });

  factory Rezultat.fromJson(Map<String, dynamic> json) =>
      _$RezultatFromJson(json);

  Map<String, dynamic> toJson() => _$RezultatToJson(this);
}
