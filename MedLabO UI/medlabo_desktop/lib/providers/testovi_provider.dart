import 'package:medlabo_desktop/models/test.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';

class TestoviProvider extends BaseProvider<Test> {
  TestoviProvider() : super("Test");

  @override
  Test fromJson(data) {
    return Test.fromJson(data);
  }
}
