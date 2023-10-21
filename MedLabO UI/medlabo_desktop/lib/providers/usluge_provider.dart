import 'package:medlabo_desktop/models/usluga/usluga.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';

class UslugeProvider extends BaseProvider<Usluga> {
  UslugeProvider() : super("Usluga");

  @override
  Usluga fromJson(data) {
    return Usluga.fromJson(data);
  }
}
