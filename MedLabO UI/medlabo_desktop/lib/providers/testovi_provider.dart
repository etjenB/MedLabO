import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import 'package:medlabo_desktop/models/test.dart';
import '../utils/general/toast_utils.dart';

class TestoviProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "Test";
  final storage = const FlutterSecureStorage();

  TestoviProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7213/");
  }

  Future<SearchResult<Test>?> get() async {
    var url = '$_baseUrl$_endpoint';
    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      var result = SearchResult<Test>();
      result.count = data['count'];

      for (var test in data['result']) {
        result.result.add(Test.fromJson(test));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    return null;
  }

  Future<Map<String, String>> createHeaders() async {
    String? token = await storage.read(key: 'jwt_token');

    if (token == null) {
      throw Exception('Token is null');
    }
    var headers = {'accept': 'text/plain', 'Authorization': 'Bearer $token'};

    return headers;
  }

  Map<String, dynamic> isValidResponse(Response response) {
    switch (response.statusCode) {
      case 401:
        return {'isValid': false, 'message': "Niste prijavljeni."};

      case 403:
        return {'isValid': false, 'message': "Nemate pravo pristupa resursu."};

      case 500:
        return {'isValid': false, 'message': "Greška na serveru."};

      default:
        if (response.statusCode >= 200 && response.statusCode <= 299) {
          return {'isValid': true, 'message': ""};
        } else {
          return {'isValid': false, 'message': "Greška."};
        }
    }
  }
}
