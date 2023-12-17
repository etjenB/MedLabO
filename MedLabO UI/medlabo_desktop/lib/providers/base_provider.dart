import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import '../utils/general/toast_utils.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? baseUrl;
  String endpoint = "";
  final storage = const FlutterSecureStorage();

  BaseProvider(String endp) {
    endpoint = endp;
    baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7213/" /* "https://localhost:7213/" */);
  }

  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = '$baseUrl$endpoint';

    if (filter != null) {
      url += '?${getQueryString(filter)}';
    }

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      var result = SearchResult<T>();
      result.count = data['count'];

      for (var test in data['result']) {
        result.result.add(fromJson(test));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }

  Future<T> getById(dynamic id) async {
    var url = '$baseUrl$endpoint/$id';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }

  Future<T> update(dynamic id, [dynamic request]) async {
    var url = '$baseUrl$endpoint/$id';

    var uri = Uri.parse(url);

    var headers = await createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed update request");
  }

  Future<T> insert(dynamic request) async {
    var url = '$baseUrl$endpoint';
    var uri = Uri.parse(url);
    var headers = await createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed insert request");
  }

  Future delete(dynamic id) async {
    var url = '$baseUrl$endpoint/$id';
    var uri = Uri.parse(url);
    var headers = await createHeaders();
    var response = await http.delete(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      return;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');
    throw Exception("Failed delete request");
  }

  T fromJson(data) {
    throw Exception("Method not implemented.");
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

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }
}
