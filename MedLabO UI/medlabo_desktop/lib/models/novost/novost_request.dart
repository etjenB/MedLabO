import 'package:json_annotation/json_annotation.dart';

part 'novost_request.g.dart';

@JsonSerializable()
class NovostRequest {
  String? naslov;
  String? sadrzaj;
  String? slika;

  NovostRequest({
    this.naslov,
    this.sadrzaj,
    this.slika,
  });

  factory NovostRequest.fromJson(Map<String, dynamic> json) =>
      _$NovostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NovostRequestToJson(this);
}
