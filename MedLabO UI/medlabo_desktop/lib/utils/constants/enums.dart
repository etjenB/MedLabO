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

//Zvanje enum-----------------------------------------------
enum ZvanjeEnum { ljekar, laboratorijskiTehnicar }

extension ZvanjeExtension on ZvanjeEnum {
  int get intValue {
    switch (this) {
      case ZvanjeEnum.ljekar:
        return 1;
      case ZvanjeEnum.laboratorijskiTehnicar:
        return 2;
      default:
        return 2;
    }
  }

  static ZvanjeEnum fromInt(int value) {
    switch (value) {
      case 1:
        return ZvanjeEnum.ljekar;
      case 2:
        return ZvanjeEnum.laboratorijskiTehnicar;
      default:
        return ZvanjeEnum.laboratorijskiTehnicar;
    }
  }

  String get displayName {
    switch (this) {
      case ZvanjeEnum.ljekar:
        return 'Ljekar';
      case ZvanjeEnum.laboratorijskiTehnicar:
        return 'Laboratorijski tehničar';
      default:
        return 'Nepoznato';
    }
  }
}

class ZvanjeConverter implements JsonConverter<ZvanjeEnum?, int?> {
  const ZvanjeConverter();

  @override
  ZvanjeEnum? fromJson(int? json) {
    return json == null ? null : ZvanjeExtension.fromInt(json);
  }

  @override
  int? toJson(ZvanjeEnum? object) {
    return object?.intValue;
  }
}
//Zvanje enum end----------------------------------------------------