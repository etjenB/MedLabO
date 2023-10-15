import 'package:json_annotation/json_annotation.dart';

part 'obavijest.g.dart';

@JsonSerializable()
class Obavijest {
  String? obavijestID;
  String? naslov;
  String? sadrzaj;
  String? dtKreiranja;
  String? dtZadnjeModifikacije;
  String? slika;
  String? administratorID;

  Obavijest(
      {this.obavijestID,
      this.naslov,
      this.sadrzaj,
      this.dtKreiranja,
      this.dtZadnjeModifikacije,
      this.slika,
      this.administratorID});

  factory Obavijest.fromJson(Map<String, dynamic> json) =>
      _$ObavijestFromJson(json);

  Map<String, dynamic> toJson() => _$ObavijestToJson(this);
}
