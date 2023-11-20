import 'package:json_annotation/json_annotation.dart';

part 'termin_zakljucak_request.g.dart';

@JsonSerializable()
class TerminZakljucak {
  String? opis;
  String? detaljno;
  String? terminID;

  TerminZakljucak({
    this.opis,
    this.detaljno,
    this.terminID,
  });

  factory TerminZakljucak.fromJson(Map<String, dynamic> json) =>
      _$TerminZakljucakFromJson(json);

  Map<String, dynamic> toJson() => _$TerminZakljucakToJson(this);
}
