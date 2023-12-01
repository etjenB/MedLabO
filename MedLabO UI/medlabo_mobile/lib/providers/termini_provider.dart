import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:medlabo_mobile/models/termin/termin.dart';
import 'package:medlabo_mobile/models/termin/termin_minimal.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';
import 'package:medlabo_mobile/utils/general/toast_utils.dart';

class TerminiProvider extends BaseProvider<Termin> {
  HttpClient client = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  late IOClient ioClient;

  TerminiProvider() : super("Termin") {
    ioClient = IOClient(client);
  }

  @override
  Termin fromJson(data) {
    return Termin.fromJson(data);
  }

  TerminMinimal fromJsonMinimal(Map<String, dynamic> json) {
    return TerminMinimal.fromJson(json);
  }

  Future<List<TerminMinimal>> getTerminiOfTheDay(DateTime day) async {
    var url =
        '${BaseProvider.baseUrl}$endpoint/GetTerminiOfTheDay/?request=${DateFormat('yyyy-MM-dd').format(day)}';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      List<TerminMinimal> result = [];

      for (var termin in data) {
        result.add(fromJsonMinimal(termin));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }

  Future terminOtkazivanje(dynamic request) async {
    var url = '${BaseProvider.baseUrl}$endpoint/TerminOtkazivanje';

    var uri = Uri.parse(url);

    var headers = await createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await ioClient.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)['isValid']) {
      notifyListeners();
      return;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed terminOtkazivanje request");
  }
}
