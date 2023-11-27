//Spol enum-----------------------------------------------
import 'package:json_annotation/json_annotation.dart';

enum SpolEnum { musko, zensko, unknown }

extension SpolExtension on SpolEnum {
  int get intValue {
    switch (this) {
      case SpolEnum.musko:
        return 1;
      case SpolEnum.zensko:
        return 2;
      default:
        return 3;
    }
  }

  static SpolEnum fromInt(int value) {
    switch (value) {
      case 1:
        return SpolEnum.musko;
      case 2:
        return SpolEnum.zensko;
      default:
        return SpolEnum.unknown;
    }
  }

  String get displayName {
    switch (this) {
      case SpolEnum.musko:
        return 'Muško';
      case SpolEnum.zensko:
        return 'Žensko';
      default:
        return 'Nepoznato';
    }
  }
}

class SpolConverter implements JsonConverter<SpolEnum?, int?> {
  const SpolConverter();

  @override
  SpolEnum? fromJson(int? json) {
    return json == null ? null : SpolExtension.fromInt(json);
  }

  @override
  int? toJson(SpolEnum? object) {
    return object?.intValue;
  }
}
//Spol enum end----------------------------------------------------