import 'package:flutter/material.dart';
import 'package:medlabo_desktop/models/test/test_request.dart';
import 'package:medlabo_desktop/models/test_parametar/test_parametar_request.dart';
import 'package:medlabo_desktop/providers/test_parametri_provider.dart';
import 'package:medlabo_desktop/providers/testovi_provider.dart';
import 'package:medlabo_desktop/utils/general/toast_utils.dart';

class TestoviAndTestParametriProvider with ChangeNotifier {
  late TestoviProvider _testoviProvider;
  late TestParametriProvider _testParametriProvider;

  TestoviAndTestParametriProvider(
      this._testoviProvider, this._testParametriProvider);

  Future updateTestAndTestParameter(
      String testId,
      TestRequest testUpdateRequest,
      String testParametarId,
      TestParametarRequest testParametarUpdateRequest) async {
    await _testoviProvider.update(testId, testUpdateRequest);
    await _testParametriProvider.update(
        testParametarId, testParametarUpdateRequest);
  }

  Future insertTestAndTestParameter(TestRequest testUpdateRequest,
      TestParametarRequest testParametarUpdateRequest) async {
    var testParametar =
        await _testParametriProvider.insert(testParametarUpdateRequest);
    testUpdateRequest.testParametarID = testParametar.testParametarID;
    try {
      await _testoviProvider.insert(testUpdateRequest);
    } catch (e) {
      await _testParametriProvider.delete(testParametar.testParametarID!);
    }
  }

  Future deleteTestAndTestParameter(
      String testId, String testPrametarId) async {
    await _testoviProvider.delete(testId);
    await _testParametriProvider.delete(testPrametarId);
  }
}
