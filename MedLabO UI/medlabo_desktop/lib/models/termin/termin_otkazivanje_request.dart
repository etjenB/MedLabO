import 'package:json_annotation/json_annotation.dart';

part 'termin_otkazivanje_request.g.dart';

@JsonSerializable()
class TerminOtkazivanjeRequest {
  String? terminID;
  String? razlogOtkazivanja;

  TerminOtkazivanjeRequest({
    this.terminID,
    this.razlogOtkazivanja,
  });

  factory TerminOtkazivanjeRequest.fromJson(Map<String, dynamic> json) =>
      _$TerminOtkazivanjeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TerminOtkazivanjeRequestToJson(this);
}
