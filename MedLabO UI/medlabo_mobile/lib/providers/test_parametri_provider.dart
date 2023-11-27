import 'package:medlabo_mobile/models/test_parametar/test_parametar.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';

class TestParametriProvider extends BaseProvider<TestParametar> {
  TestParametriProvider() : super("TestParametar");

  @override
  TestParametar fromJson(data) {
    return TestParametar.fromJson(data);
  }
}
