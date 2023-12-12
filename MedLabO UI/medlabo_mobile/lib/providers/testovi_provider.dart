import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:medlabo_mobile/models/test/test.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';

class TestoviProvider extends BaseProvider<Test> {
  HttpClient client = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  late IOClient ioClient;

  TestoviProvider() : super("Test") {
    ioClient = IOClient(client);
  }

  @override
  Test fromJson(data) {
    return Test.fromJson(data);
  }

  Future<List<Test>> getTestoviBasicData() async {
    var url = '${BaseProvider.baseUrl}$endpoint/GetTestoviBasicData';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      List<Test> result = [];

      for (var test in data) {
        result.add(fromJson(test));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }

  Future<List<Test>> getTestoviByTerminId(String terminId) async {
    var url = '${BaseProvider.baseUrl}$endpoint/GetTestoviByTerminId/$terminId';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      List<Test> result = [];

      for (var test in data) {
        result.add(fromJson(test));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }

  Future<List<Test>> getTestoviByUslugaId(int uslugaId) async {
    var url = '${BaseProvider.baseUrl}$endpoint/GetTestoviByUslugaId/$uslugaId';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      List<Test> result = [];

      for (var test in data) {
        result.add(fromJson(test));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }

  Future<List<Test>> getTestoviBasicDataByUslugaId(int uslugaId) async {
    var url =
        '${BaseProvider.baseUrl}$endpoint/GetTestoviBasicDataByUslugaId/$uslugaId';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      List<Test> result = [];

      for (var test in data) {
        result.add(fromJson(test));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }
}
