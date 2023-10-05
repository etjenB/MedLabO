import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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

double? parseStringToDouble(String value) {
  double? newDouble;
  try {
    newDouble = double.parse(value);
  } catch (e) {
    return null;
  }
  return newDouble;
}
