import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:medlabo_mobile/models/stripe/payment_intent_create_request.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';

class StripeProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "";
  final storage = const FlutterSecureStorage();

  StripeProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue:
            /* "https://192.168.1.10:7213/" */ /*za emulator "https://10.0.2.2:7213/" */ "https://10.0.2.2:7213/");
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      PaymentIntentCreateRequest request) async {
    var url = '$_baseUrl${_endpoint}CreatePaymentIntent';
    var uri = Uri.parse(url);

    var headers = await createHeaders();

    final client = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    final ioClient = IOClient(client);

    var jsonRequest = jsonEncode(request);

    final response = await ioClient.post(
      uri,
      headers: headers,
      body: jsonRequest,
    );

    client.close();

    if (isValidResponse(response)['isValid']) {
      return json.decode(response.body);
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');
    throw Exception("Failed create payment intent request");
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
}
