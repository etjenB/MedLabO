import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:medlabo_desktop/models/search_result.dart';
import '../utils/general/toast_utils.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint = "";
  final storage = const FlutterSecureStorage();

  BaseProvider(String endpoint) {
    _endpoint = endpoint;
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7213/");
  }

  Future<SearchResult<T>?> get({dynamic filter}) async {
    var url = '$_baseUrl$_endpoint';

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

    return null;
  }

  Future<T?> getById(String id) async {
    var url = '$_baseUrl$_endpoint/$id';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    return null;
  }

  T fromJson(data) {
    throw Exception("Method not implemented.");
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
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
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