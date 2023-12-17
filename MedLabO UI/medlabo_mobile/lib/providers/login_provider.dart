import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medlabo_mobile/models/pacijent/pacijent_registration_request.dart';
import 'package:medlabo_mobile/utils/constants/strings.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';

class LoginProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "Auth";
  final storage = const FlutterSecureStorage();

  LoginProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue:
            /* "https://192.168.1.10:7213/" */ /*za emulator "https://10.0.2.2:7213/" */ "https://10.0.2.2:7213/");
  }

  Future<bool> login(String username, String password) async {
    var url = '$_baseUrl$_endpoint/Login';
    var uri = Uri.parse(url);

    final client = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    final ioClient = IOClient(client);

    final response = await ioClient.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    client.close();

    if (response.statusCode == 200) {
      var token = jsonDecode(response.body)['token'];
      final Map<String, dynamic> data = JwtDecoder.decode(token);
      var role = data['role'];
      if (role == roles[RolesEnum.pacijent]) {
        await storage.write(key: 'jwt_token', value: token);
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  Future<bool> pacijentRegistration(PacijentRegistrationRequest request) async {
    var url = '$_baseUrl$_endpoint/PacijentRegistration';
    var uri = Uri.parse(url);

    final client = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    final ioClient = IOClient(client);

    var jsonRequest = jsonEncode(request);

    final response = await ioClient.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonRequest,
    );

    client.close();

    if (isValidResponse(response)['isValid']) {
      var token = jsonDecode(response.body)['token'];
      final Map<String, dynamic> data = JwtDecoder.decode(token);
      var role = data['role'];
      if (role == roles[RolesEnum.pacijent]) {
        await storage.write(key: 'jwt_token', value: token);
        return true;
      }
      return false;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');
    throw Exception("Failed delete request");
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
