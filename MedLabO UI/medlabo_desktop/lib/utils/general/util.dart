import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';

Image imageFromBase64String(String base64Image) {
  return Image.memory(base64Decode(base64Image));
}

String formatNumberToPrice(dynamic) {
  var f = NumberFormat('###.0#KM');
  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

String formatNumberToMinutes(dynamic) {
  if (dynamic == null) {
    return "";
  }

  String suffix;
  int lastDigit = dynamic % 10;
  int lastTwoDigits = dynamic % 100;

  if (lastDigit == 1 && lastTwoDigits != 11) {
    suffix = "Minuta";
  } else if (lastDigit >= 2 &&
      lastDigit <= 4 &&
      (lastTwoDigits < 10 || lastTwoDigits > 20)) {
    suffix = "Minute";
  } else {
    suffix = "Minuta";
  }

  var f = NumberFormat('###');
  return "${f.format(dynamic)} $suffix";
}

String formatNumberToHours(dynamic) {
  var f = NumberFormat('###.#h');
  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

double? parseStringToDouble(String value) {
  double? newDouble;
  try {
    newDouble = double.parse(value);
  } catch (e) {
    return null;
  }
  return newDouble;
}

int? parseStringToInt(String value) {
  int? newInt;
  try {
    newInt = int.parse(value);
  } catch (e) {
    return null;
  }
  return newInt;
}

String? formatDateTime(String dateTimeString,
    {String format = "dd.MM.yyyy HH:mm"}) {
  try {
    DateTime parsedDate = DateTime.parse(dateTimeString);
    return DateFormat(format).format(parsedDate);
  } catch (e) {
    makeErrorToast('Error formating date: $e');
    return null;
  }
}
