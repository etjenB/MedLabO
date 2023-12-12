import 'package:medlabo_desktop/models/pacijent/pacijent.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';

class PacijentProvider extends BaseProvider<Pacijent> {
  PacijentProvider() : super("Pacijent");

  @override
  Pacijent fromJson(data) {
    return Pacijent.fromJson(data);
  }
}
