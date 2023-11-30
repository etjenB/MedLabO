import 'package:json_annotation/json_annotation.dart';

part 'termin_insert_request.g.dart';

@JsonSerializable()
class TerminInsertRequest {
  String? dtTermina;
  String? napomena;
  List<String>? usluge;
  List<String>? testovi;

  TerminInsertRequest(
      {this.dtTermina, this.napomena, this.usluge, this.testovi});

  factory TerminInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$TerminInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TerminInsertRequestToJson(this);
}
