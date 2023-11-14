import 'dart:convert';

import 'package:medlabo_desktop/models/test/test.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:medlabo_desktop/utils/general/toast_utils.dart';

class TestoviProvider extends BaseProvider<Test> {
  TestoviProvider() : super("Test");

  @override
  Test fromJson(data) {
    return Test.fromJson(data);
  }

  Future<List<Test>> getTestoviByTerminId(String terminId) async {
    var url = '${BaseProvider.baseUrl}$endpoint/GetTestoviByTerminId/$terminId';

    var uri = Uri.parse(url);

    var headers = await createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)['isValid']) {
      var data = jsonDecode(response.body);

      List<Test> result = [];

      for (var test in data) {
        result.add(fromJson(test));
      }

      return result;
    }

    makeErrorToast(isValidResponse(response)['message'] ?? '');

    throw Exception("Failed get request");
  }
}
