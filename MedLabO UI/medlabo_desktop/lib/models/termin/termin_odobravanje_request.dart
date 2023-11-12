import 'package:json_annotation/json_annotation.dart';

part 'termin_odobravanje_request.g.dart';

@JsonSerializable()
class TerminOdobravanjeRequest {
  String? terminID;
  String? odgovor;
  bool? status;

  TerminOdobravanjeRequest({
    this.terminID,
    this.odgovor,
    this.status,
  });

  factory TerminOdobravanjeRequest.fromJson(Map<String, dynamic> json) =>
      _$TerminOdobravanjeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TerminOdobravanjeRequestToJson(this);
}
