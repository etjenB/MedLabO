import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medlabo_desktop/models/administrator/administrator.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';

class AdministratoriProvider extends BaseProvider<Administrator> {
  AdministratoriProvider() : super("Administrator");

  @override
  Administrator fromJson(data) {
    return Administrator.fromJson(data);
  }

  Future changePassword(dynamic request) async {
    var url = '${BaseProvider.baseUrl}$endpoint/ChangePassword';

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
