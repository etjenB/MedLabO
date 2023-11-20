import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_desktop/models/rezultat/rezultat.dart';

part 'termin_test_rezultat_request.g.dart';

@JsonSerializable()
class TerminTestRezultat {
  String? terminID;
  List<String>? testIDs;
  List<Rezultat>? rezultati;

  TerminTestRezultat({
    this.terminID,
    this.testIDs,
    this.rezultati,
  });

  factory TerminTestRezultat.fromJson(Map<String, dynamic> json) =>
      _$TerminTestRezultatFromJson(json);

  Map<String, dynamic> toJson() => _$TerminTestRezultatToJson(this);
}
