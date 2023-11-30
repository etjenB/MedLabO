import 'package:json_annotation/json_annotation.dart';

part 'zvanje.g.dart';

@JsonSerializable()
class Zvanje {
  int? zvanjeID;
  String? naziv;
  String? opis;

  Zvanje({this.zvanjeID, this.naziv, this.opis});

  factory Zvanje.fromJson(Map<String, dynamic> json) => _$ZvanjeFromJson(json);

  Map<String, dynamic> toJson() => _$ZvanjeToJson(this);
}
