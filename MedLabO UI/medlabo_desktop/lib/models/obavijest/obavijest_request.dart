import 'package:json_annotation/json_annotation.dart';

part 'obavijest_request.g.dart';

@JsonSerializable()
class ObavijestRequest {
  String? naslov;
  String? sadrzaj;
  String? slika;

  ObavijestRequest({
    this.naslov,
    this.sadrzaj,
    this.slika,
  });

  factory ObavijestRequest.fromJson(Map<String, dynamic> json) =>
      _$ObavijestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ObavijestRequestToJson(this);
}
