import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medlabo_desktop/models/termin/termin.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';

class TerminiProvider extends BaseProvider<Termin> {
  TerminiProvider() : super("Termin");

  @override
  Termin fromJson(data) {
    return Termin.fromJson(data);
  }

  Future terminOdobravanje(dynamic request) async {
    var url = '${BaseProvider.baseUrl}$endpoint/TerminOdobravanje';

    var uri = Uri.parse(url);

    var headers = await createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)['isValid']) {
      return;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed update request");
  }
}
