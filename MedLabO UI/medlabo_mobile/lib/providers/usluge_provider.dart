import 'dart:convert';

import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:medlabo_mobile/utils/general/toast_utils.dart';

class UslugeProvider extends BaseProvider<Usluga> {
  UslugeProvider() : super("Usluga");

  @override
  Usluga fromJson(data) {
    return Usluga.fromJson(data);
  }

  Future<List<Usluga>> getUslugeBasicData() async {
    var url = '${BaseProvider.baseUrl}$endpoint/GetUslugeBasicData';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      List<Usluga> result = [];

      for (var usluga in data) {
        result.add(fromJson(usluga));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }

  Future<List<Usluga>> getUslugeByTerminId(String terminId) async {
    var url = '${BaseProvider.baseUrl}$endpoint/GetUslugeByTerminId/$terminId';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      List<Usluga> result = [];

      for (var usluga in data) {
        result.add(fromJson(usluga));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }
}