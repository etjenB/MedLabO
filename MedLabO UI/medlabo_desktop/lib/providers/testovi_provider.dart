import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TestoviProvider with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint = "Test";

  TestoviProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7213/");
  }

  Future<dynamic> get() async {
    var url = '$_baseUrl$_endpoint';
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    var data = jsonDecode(response.body);

    return data;
  }

  Map<String, String> createHeaders() {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiZTZiYjNjNDktOWFhNi00ZWYwLTk2MjUtYjE2YmIzNzc1ZTU4Iiwicm9sZSI6IkFkbWluaXN0cmF0b3IiLCJuYmYiOjE2OTM3NjMzOTEsImV4cCI6MTY5Mzc4MTM5MSwiaWF0IjoxNjkzNzYzMzkxfQ.2qKIszfJ3sb1c_y2zXYDEk5hKLbT81IQpldj44xl9iE";

    var headers = {'accept': 'text/plain', 'Authorization': 'Bearer $token'};

    return headers;
  }
}
