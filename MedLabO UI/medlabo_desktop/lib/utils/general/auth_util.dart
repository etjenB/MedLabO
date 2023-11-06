import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthUtil {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String _token;
  late Map<String, dynamic> decodedToken;

  AuthUtil._(this._token, this.decodedToken);

  static Future<AuthUtil> create() async {
    final token = await FlutterSecureStorage().read(key: 'jwt_token') ?? '';
    final decodedToken = JwtDecoder.decode(token);
    return AuthUtil._(token, decodedToken);
  }

  String getUserId() {
    return decodedToken['name'];
  }

  bool isAdministrator() {
    return decodedToken['role'] == 'Administrator';
  }

  bool isMedicinskoOsoblje() {
    return decodedToken['role'] == 'MedicinskoOsoblje';
  }

  bool isTokenExpired() {
    return JwtDecoder.isExpired(_token);
  }
}
