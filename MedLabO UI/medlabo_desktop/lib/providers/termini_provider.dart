import 'package:medlabo_desktop/models/termin/termin.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';

class TerminiProvider extends BaseProvider<Termin> {
  TerminiProvider() : super("Termin");

  @override
  Termin fromJson(data) {
    return Termin.fromJson(data);
  }
}
