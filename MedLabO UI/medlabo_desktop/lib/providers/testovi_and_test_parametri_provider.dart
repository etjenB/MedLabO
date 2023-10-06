import 'package:flutter/material.dart';
import 'package:medlabo_desktop/models/test/test_update_request.dart';
import 'package:medlabo_desktop/models/test_parametar/test_parametar_update_request.dart';
import 'package:medlabo_desktop/providers/test_parametri_provider.dart';
import 'package:medlabo_desktop/providers/testovi_provider.dart';

class TestoviAndTestParametriProvider with ChangeNotifier {
  late TestoviProvider _testoviProvider;
  late TestParametriProvider _testParametriProvider;

  TestoviAndTestParametriProvider(
      this._testoviProvider, this._testParametriProvider);

  Future updateTestAndTestParameter(
      String testId,
      TestUpdateRequest testUpdateRequest,
      String testParametarId,
      TestParametarUpdateRequest testParametarUpdateRequest) async {
    await _testoviProvider.update(testId, testUpdateRequest);
    await _testParametriProvider.update(
        testParametarId, testParametarUpdateRequest);
  }
}
