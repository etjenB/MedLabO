import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:medlabo_mobile/utils/constants/strings.dart';

class LoginProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "Auth/Login";
  final storage = const FlutterSecureStorage();

  LoginProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue:
            "https://192.168.1.10:7213/" /*za emulator "https://10.0.2.2:7213/" */);
  }

  Future<bool> login(String username, String password) async {
    var url = '$_baseUrl$_endpoint';
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
}
