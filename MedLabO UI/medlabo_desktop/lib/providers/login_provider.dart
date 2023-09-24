import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "Auth/Login";
  final storage = const FlutterSecureStorage();

  LoginProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7213/");
  }

  Future<bool> login(String username, String password) async {
    var url = '$_baseUrl$_endpoint';
    var uri = Uri.parse(url);

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      String token = data['token'];
      await storage.write(key: 'jwt_token', value: token);
      return true;
    } else {
      return false;
    }
  }
}
