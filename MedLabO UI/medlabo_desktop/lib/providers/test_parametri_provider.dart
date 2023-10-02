import 'package:medlabo_desktop/models/test_parametar.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';

class TestParametriProvider extends BaseProvider<TestParametar> {
  TestParametriProvider() : super("TestParametar");

  @override
  TestParametar fromJson(data) {
    return TestParametar.fromJson(data);
  }
}
