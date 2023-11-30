import 'package:medlabo_mobile/models/termin/termin.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';

class TerminiProvider extends BaseProvider<Termin> {
  TerminiProvider() : super("Termin");

  @override
  Termin fromJson(data) {
    return Termin.fromJson(data);
  }
}
