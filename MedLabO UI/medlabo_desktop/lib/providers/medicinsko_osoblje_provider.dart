import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medlabo_desktop/models/uposlenik/medicinsko_osoblje.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';

class MedicinskoOsobljeProvider extends BaseProvider<MedicinskoOsoblje> {
  MedicinskoOsobljeProvider() : super("MedicinskoOsoblje");

  @override
  MedicinskoOsoblje fromJson(data) {
    return MedicinskoOsoblje.fromJson(data);
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
