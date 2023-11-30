import 'package:json_annotation/json_annotation.dart';

part 'termin_minimal.g.dart';

@JsonSerializable()
class TerminMinimal {
  String? terminID;
  DateTime? dtTermina;

  TerminMinimal({
    this.terminID,
    this.dtTermina,
  });

  factory TerminMinimal.fromJson(Map<String, dynamic> json) =>
      _$TerminMinimalFromJson(json);

  Map<String, dynamic> toJson() => _$TerminMinimalToJson(this);
}
