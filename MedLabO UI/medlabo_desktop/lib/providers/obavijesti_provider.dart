import 'package:medlabo_desktop/models/obavijest/obavijest.dart';
import 'package:medlabo_desktop/providers/base_provider.dart';

class ObavijestiProvider extends BaseProvider<Obavijest> {
  ObavijestiProvider() : super("Obavijest");

  @override
  Obavijest fromJson(data) {
    return Obavijest.fromJson(data);
  }
}
