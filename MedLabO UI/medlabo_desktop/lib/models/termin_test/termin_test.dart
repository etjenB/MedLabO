import 'package:json_annotation/json_annotation.dart';
import 'package:medlabo_desktop/models/rezultat/rezultat.dart';
import 'package:medlabo_desktop/models/test/test.dart';

part 'termin_test.g.dart';

@JsonSerializable()
class TerminTest {
  String? terminID;
  String? testID;
  Test? test;
  String? rezultatID;
  Rezultat? rezultat;

  TerminTest(
    this.terminID,
    this.testID,
    this.test,
    this.rezultatID,
    this.rezultat,
  );

  factory TerminTest.fromJson(Map<String, dynamic> json) =>
      _$TerminTestFromJson(json);

  Map<String, dynamic> toJson() => _$TerminTestToJson(this);
}
