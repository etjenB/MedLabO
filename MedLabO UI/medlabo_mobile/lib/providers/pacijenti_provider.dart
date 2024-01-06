import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:medlabo_mobile/models/pacijent/pacijent.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';

class PacijentProvider extends BaseProvider<Pacijent> {
  HttpClient client = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  late IOClient ioClient;

  PacijentProvider() : super("Pacijent") {
    ioClient = IOClient(client);
  }

  @override
  Pacijent fromJson(data) {
    return Pacijent.fromJson(data);
  }

  Future changePassword(dynamic request) async {
    var url = '${BaseProvider.baseUrl}$endpoint/ChangePassword';

    var uri = Uri.parse(url);

    var headers = await createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await ioClient.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)['isValid']) {
      return;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed update request");
  }
}
