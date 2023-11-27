import 'package:medlabo_mobile/models/novost/novost.dart';
import 'package:medlabo_mobile/providers/base_provider.dart';

class NovostiProvider extends BaseProvider<Novost> {
  NovostiProvider() : super("Novost");

  @override
  Novost fromJson(data) {
    return Novost.fromJson(data);
  }
}
