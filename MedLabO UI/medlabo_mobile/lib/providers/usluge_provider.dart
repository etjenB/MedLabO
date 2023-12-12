import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:medlabo_mobile/models/usluga/usluga.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';

class UslugeProvider extends BaseProvider<Usluga> {
  HttpClient client = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  late IOClient ioClient;

  UslugeProvider() : super("Usluga") {
    ioClient = IOClient(client);
  }

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

  Future<int?> getPacijentLastChosenUsluga() async {
    var url = '${BaseProvider.baseUrl}$endpoint/GetPacijentLastChosenUsluga';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return null;
    }

    makeErrorToast('Greška prilikom pribavljanja id-a usluge pacijenta.');

    throw Exception("Failed get request");
  }

  Future<List<Usluga>> recommend(int uslugaId) async {
    var url = '${BaseProvider.baseUrl}$endpoint/Recommend/$uslugaId';

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
}
