import 'package:json_annotation/json_annotation.dart';

part 'novost.g.dart';

@JsonSerializable()
class Novost {
  String? novostID;
  String? naslov;
  String? sadrzaj;
  String? dtKreiranja;
  String? dtZadnjeModifikacije;
  String? slika;
  String? administratorID;

  Novost(
      {this.novostID,
      this.naslov,
      this.sadrzaj,
      this.dtKreiranja,
      this.dtZadnjeModifikacije,
      this.slika,
      this.administratorID});

  factory Novost.fromJson(Map<String, dynamic> json) => _$NovostFromJson(json);

  Map<String, dynamic> toJson() => _$NovostToJson(this);
}
