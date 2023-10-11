import 'package:medlabo_desktop/models/novost/novost.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';

class NovostiProvider extends BaseProvider<Novost> {
  NovostiProvider() : super("Novost");

  @override
  Novost fromJson(data) {
    return Novost.fromJson(data);
  }
}
