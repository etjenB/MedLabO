import 'package:json_annotation/json_annotation.dart';

part 'spol.g.dart';

@JsonSerializable()
class Spol {
  int? spolID;
  String? kod;
  String? naziv;

  Spol({this.spolID, this.kod, this.naziv});

  factory Spol.fromJson(Map<String, dynamic> json) => _$SpolFromJson(json);

  Map<String, dynamic> toJson() => _$SpolToJson(this);
}
