import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:medlabo_mobile/models/zakljucak/zakljucak.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';

class ZakljucciProvider with ChangeNotifier {
  HttpClient client = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  late IOClient ioClient;
  final storage = const FlutterSecureStorage();
  var endpoint = "Zakljucak";

  ZakljucciProvider() {
    ioClient = IOClient(client);
  }

  Future<Zakljucak> getZakljucakByTerminID(String terminID) async {
    var url =
        '${BaseProvider.baseUrl}$endpoint/GetZakljucakByTerminID/$terminID';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      return Zakljucak.fromJson(data);
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }

  Future<Map<String, String>> createHeaders() async {
    String? token = await storage.read(key: 'jwt_token');

    if (token == null) {
      throw Exception('Token is null');
    }
    var headers = {
      'Content-Type': 'application/json',
      'accept': 'text/plain',
      'Authorization': 'Bearer $token'
    };

    return headers;
  }

  Map<String, dynamic> isValidResponse(Response response) {
    switch (response.statusCode) {
      case 401:
        return {'isValid': false, 'message': "Niste prijavljeni."};

      case 403:
        return {'isValid': false, 'message': "Nemate pravo pristupa resursu."};

      case 500:
        return {
          'isValid': false,
          'message': extractErrorMessage(response.body)
        };

      default:
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          return {'isValid': true, 'message': ""};
        } else {
          return {
            'isValid': false,
            'message': extractErrorMessage(response.body)
          };
        }
    }
  }

  String extractErrorMessage(String responseBody) {
    try {
      var parsedJson = jsonDecode(responseBody);
      if (parsedJson.containsKey('errors') &&
          parsedJson['errors'].containsKey('Error') &&
          parsedJson['errors']['Error'].isNotEmpty) {
        return parsedJson['errors']['Error'][0];
      }
    } catch (e) {
      return responseBody;
    }
    return responseBody;
  }
}
