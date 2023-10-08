import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medlabo_desktop/utils/constants/strings.dart';

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
      var token = jsonDecode((response.body))['token'];
      final Map<String, dynamic> data = JwtDecoder.decode(token);
      var role = data['role'];
      if (role == roles[RolesEnum.administrator] ||
          role == roles[RolesEnum.medicinskoOsoblje]) {
        await storage.write(key: 'jwt_token', value: token);
        return true;
      }
      return false;
    } else {
      return false;
    }
  }
}
