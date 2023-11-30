import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_mobile/models/termin/termin.dart';

part 'racun.g.dart';

@JsonSerializable()
class Racun {
  double? cijena;
  bool? placeno;
  Termin? termin;

  Racun(
    this.cijena,
    this.placeno,
    this.termin,
  );

  factory Racun.fromJson(Map<String, dynamic> json) => _$RacunFromJson(json);

  Map<String, dynamic> toJson() => _$RacunToJson(this);
}
