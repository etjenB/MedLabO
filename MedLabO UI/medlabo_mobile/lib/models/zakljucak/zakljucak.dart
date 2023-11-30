import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_mobile/models/termin/termin.dart';

part 'zakljucak.g.dart';

@JsonSerializable()
class Zakljucak {
  String? opis;
  String? detaljno;
  Termin? termin;

  Zakljucak(
    this.opis,
    this.detaljno,
    this.termin,
  );

  factory Zakljucak.fromJson(Map<String, dynamic> json) =>
      _$ZakljucakFromJson(json);

  Map<String, dynamic> toJson() => _$ZakljucakToJson(this);
}
